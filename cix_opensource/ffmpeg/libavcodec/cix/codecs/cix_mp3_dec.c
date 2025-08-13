/*
 * cix dsp mp3 decoder
 * Copyright 2024 Cix Technology Group Co., Ltd.

 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the “Software”),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software
 * is furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <stdint.h>

#include "libavutil/attributes.h"
#include "libavutil/audio_fifo.h"
#include "libavutil/channel_layout.h"
#include "libavutil/ffmath.h"
#include "libavutil/float_dsp.h"
#include "libavutil/frame.h"
#include "libavutil/mem_internal.h"
#include "libavutil/opt.h"

#include "libswresample/swresample.h"

#include "libavcodec/avcodec.h"
#include "libavcodec/codec_internal.h"
#include "libavcodec/decode.h"
#include "libavcodec/internal.h"

#include "libavutil/intreadwrite.h"
#include "libavcodec/mpegaudio.h"
#include "libavcodec/mpegaudiodecheader.h"

#include "audio_dsp_if.h"

#define HEADER_SIZE 4

typedef struct cix_mp3Context {
    MPA_DECODE_HEADER

    struct cix_dsp_if *dsp_if;
} cixdsp_mp3Context;

struct cix_dsp_lib* dsp_lib;

static int cix_dsp_mp3_dec_frame(AVCodecContext *avctx, AVFrame *frame,
                                 int *got_frame_ptr, AVPacket *avpkt)
{
    cixdsp_mp3Context *c = avctx->priv_data;
    struct cix_dsp_if *dsp_if = c->dsp_if;
    int decoded_samples = INT_MAX;
    enum AVSampleFormat fmt = AV_SAMPLE_FMT_S16;
    int ret;

    if (!avctx->bit_rate)
        avctx->bit_rate = c->bit_rate;

    switch(c->layer) {
    case 1:
        c->frame_size = 384;
        break;
    case 2:
        c->frame_size = 1152;
        break;
    case 3:
    default:
        c->frame_size = c->lsf ? 576 : 1152;
        break;
    }

    dsp_if->avctx = avctx;
    dsp_if->pkt = avpkt;
    dsp_if->frame = frame;

    frame->format = avctx->sample_fmt;
    frame->sample_rate = avctx->sample_rate;
    frame->ch_layout = avctx->ch_layout;

    /* setup the data buffers */
    frame->nb_samples = dsp_if->outbuf_size;
    ret = ff_get_buffer(avctx, frame, 0);
    if (ret < 0)
        return ret;

    decoded_samples = audio_dsp_component_handle_frame_decoder(dsp_if);

    /* check once, update codec info */
    if (dsp_if->param_updated) {
        dsp_if->param_updated = false;

        if (dsp_if->sample_rate > 0) {
            frame->sample_rate = dsp_if->sample_rate;
            avctx->sample_rate = dsp_if->sample_rate;
        }
        if (dsp_if->channels > 0) {
            av_channel_layout_uninit(&avctx->ch_layout);
            av_channel_layout_default(&avctx->ch_layout, dsp_if->channels);
            frame->ch_layout = avctx->ch_layout;
        }
        if (dsp_if->width > 0) {
            switch (dsp_if->width) {
                case 32:
                case 24:
                    fmt = AV_SAMPLE_FMT_S32;
                    break;
                case 16:
                default:
                    fmt = AV_SAMPLE_FMT_S16;
                    break;
            }
            avctx->sample_fmt = fmt;
            frame->format = fmt;
        }
    }

    frame->nb_samples = decoded_samples / (avctx->ch_layout.nb_channels * av_get_bytes_per_sample(fmt));
    *got_frame_ptr    = !!decoded_samples;

    return *got_frame_ptr ? decoded_samples : 0;
}

static av_cold int cix_dsp_mp3_dec_init(AVCodecContext *avctx)
{
    cixdsp_mp3Context *c = avctx->priv_data;
    struct cix_dsp_if *dsp_if;
    int channels = 2;

    avctx->sample_fmt  = AV_SAMPLE_FMT_S16;
    avctx->sample_rate = 48000;
    av_channel_layout_uninit(&avctx->ch_layout);
    av_channel_layout_default(&avctx->ch_layout, channels);

    dsp_if = (struct cix_dsp_if *)av_mallocz(sizeof(struct cix_dsp_if));
    if (!dsp_if)
        return AVERROR(ENOMEM);

    if (!dsp_lib || !dsp_lib->lib)
    {
        av_log(avctx, AV_LOG_ERROR,
               "audio_dsp_load_if() returned with error.\n");
        av_freep(&dsp_if);
        return AVERROR_EXTERNAL;
    }
    dsp_if->lib = dsp_lib->lib;
    dsp_if->dsp_api = dsp_lib->dsp_api;

    audio_dsp_component_create(dsp_if, DSPCOMP_OPCODE_DECODER, DSPCOMP_FMT_MP3);
    c->dsp_if = dsp_if;

    return 0;
}

static av_cold int cix_dsp_mp3_dec_close(AVCodecContext *avctx)
{
    cixdsp_mp3Context *c = avctx->priv_data;
    struct cix_dsp_if *dsp_if = c->dsp_if;

    audio_dsp_component_delete(dsp_if);
    av_freep(&dsp_if);

    return 0;
}

static av_cold void cix_dsp_mp3_dec_flush(AVCodecContext *avctx)
{
    cixdsp_mp3Context *c = avctx->priv_data;

    audio_dsp_component_flush(c->dsp_if);
}

static void cix_dsp_mp3_dec_init_static_data(FFCodec *codec)
{
    dsp_lib = (struct cix_dsp_lib *)av_mallocz(sizeof(struct cix_dsp_lib));
    if (!dsp_lib)
    {
        av_log(NULL, AV_LOG_ERROR, "failed to allocate dsp_lib\n");
        return;
    }
    if (audio_dsp_load_lib(dsp_lib) == false)
    {
        av_log(NULL, AV_LOG_ERROR, "load lib error.\n");
        av_freep(&dsp_lib);
        return;
    }
}

const FFCodec ff_cix_dsp_mp3_decoder = {
    .p.name          = "cix_mp3",
    .p.long_name    = NULL_IF_CONFIG_SMALL("MP3 (MPEG audio layer 3)"),
    .p.type          = AVMEDIA_TYPE_AUDIO,
    .p.id            = AV_CODEC_ID_MP3,
    .priv_data_size  = sizeof(cixdsp_mp3Context),
    .init            = cix_dsp_mp3_dec_init,
    .init_static_data   = cix_dsp_mp3_dec_init_static_data,
    .close           = cix_dsp_mp3_dec_close,
    FF_CODEC_DECODE_CB(cix_dsp_mp3_dec_frame),
    .flush           = cix_dsp_mp3_dec_flush,
    .p.capabilities = AV_CODEC_CAP_CHANNEL_CONF |
                      AV_CODEC_CAP_DR1,
};
