/* 
 * cix audio dsp interface
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

#ifndef __AUDIO_DSP_IF_H__
#define __AUDIO_DSP_IF_H__

#include <stdbool.h>

#include "cix_dsp_api.h"

#include "libavcodec/avcodec.h"
#include "libavcodec/codec_internal.h"

struct dsp_comp_interface
{
    dspcomp_get_version comp_get_version;
    dspcomp_create comp_create;
    dspcomp_delete comp_delete;
    dspcomp_flush comp_flush;
    dspcomp_get_param comp_get_param;
    dspcomp_set_param comp_set_param;
    dspcomp_process_frame_out_disconnect_sync comp_process_frame_out_disconnect_sync;
};

struct dsp_format
{
    int sample_rate;
    int channels;
    int width;
    int audobjtype;
    int bsformat;
    int bitrate;
};

/* DSP APIs */
struct cix_dsp_if
{
    AVCodecContext *avctx;
    AVPacket *pkt;
    AVFrame *frame;

    void *lib;
    dspcomp_handle dsp_comp;
    struct dsp_comp_interface dsp_api;

    char *p_inbuf, *p_outbuf;
    unsigned int inbuf_size, outbuf_size;

    unsigned int total_input;
    unsigned int total_output;
    unsigned int samples_per_frame;

    /* got params from decoder/encoder */
    int sample_rate;
    int channels;
    int width;
    bool param_updated;

    /* comp info */
    dspcomp_opcode opcode;
};

struct cix_dsp_lib
{
    void *lib;
    struct dsp_comp_interface dsp_api;
};

bool audio_dsp_load_if(struct cix_dsp_if *dsp_if);
bool audio_dsp_load_lib(struct cix_dsp_lib *dsp_lib);
bool audio_dsp_unload_if(struct cix_dsp_if *dsp_if);

bool audio_dsp_component_create(struct cix_dsp_if *dsp_if,
                                dspcomp_opcode opcode,
                                dspcomp_format format);
void audio_dsp_component_delete(struct cix_dsp_if *dsp_if);

int audio_dsp_component_handle_frame_decoder(struct cix_dsp_if *dsp_if);
int audio_dsp_component_handle_frame_encoder(struct cix_dsp_if *dsp_if);

int audio_dsp_component_flush(struct cix_dsp_if *dsp_if);

void audio_dsp_component_set_format(struct cix_dsp_if *dsp_if, struct dsp_format *fmt);

#endif /* __AUDIO_DSP_IF_H__ */
