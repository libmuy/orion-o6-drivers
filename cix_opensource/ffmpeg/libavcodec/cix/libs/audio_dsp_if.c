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

#include <dlfcn.h>
#include "audio_dsp_if.h"

#define DSP_API_LIB_NAME "libdsp_wrap.so"

static dspcomp_errcode cix_load_dsp_api(AVCodecContext *avctx,
                                        dspcomp_query_interface comp_query_interface,
                                        struct dsp_comp_interface *interface)
{
    dspcomp_errcode ret;

    ret = comp_query_interface(API_DSPCOMP_GET_VERSION,
                               (void **)&(interface->comp_get_version));
    if (ret < 0) {
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_GET_VERSION failed, ret = %d\n", ret);
        return ret;
    }
    ret = comp_query_interface(API_DSPCOMP_CREATE,
                               (void **)&(interface->comp_create));
    if (ret < 0) {
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_CREATE failed, ret = %d\n", ret);
        return ret;
    }
    ret = comp_query_interface(API_DSPCOMP_DELETE,
                               (void **)&(interface->comp_delete));
    if (ret < 0) {
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_DELETE failed, ret = %d\n", ret);
        return ret;
    }
    ret = comp_query_interface(API_DSPCOMP_FLUSH,
                               (void **) &(interface->comp_flush));
    if (ret < 0) {
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_FLUSH failed, ret = %d\n", ret);
        return ret;
    }
    ret = comp_query_interface(API_DSPCOMP_GET_PARAM,
                               (void **) &(interface->comp_get_param));
    if (ret < 0) {
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_GET_PARAM failed, ret = %d\n", ret);
        return ret;
    }
    ret = comp_query_interface(API_DSPCOMP_SET_PARAM,
                               (void **) &(interface->comp_set_param));
    if (ret < 0) {
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_SET_PARAM failed, ret = %d\n", ret);
        return ret;
    }
    ret = comp_query_interface(API_DSPCOMP_PROCESS_FRAME_OUT_DISCONNECT_SYNC,
                               (void **) &(interface->comp_process_frame_out_disconnect_sync));
    if (ret < 0)
        av_log(avctx, AV_LOG_ERROR,
            "query interface: API_DSPCOMP_PROCESS_FRAME_OUT_DISCONNECT_SYNC failed, ret = %d\n",
            ret);

    return ret;
}

bool audio_dsp_load_if(struct cix_dsp_if *dsp_if)
{
    dspcomp_query_interface comp_query_interface;
    const char *wrap_version;
    dspcomp_errcode ret;

    dsp_if->lib = dlopen(DSP_API_LIB_NAME, RTLD_NOW | RTLD_GLOBAL);
    if (!dsp_if->lib) {
        av_log(dsp_if->avctx, AV_LOG_ERROR, "dsp wrap api lib(%s) not found.\n",
            DSP_API_LIB_NAME);
        goto fail;
    }

    comp_query_interface = dlsym(dsp_if->lib, (char *)"dsp_comp_query_interface");
    if (!comp_query_interface) {
        av_log(dsp_if->avctx, AV_LOG_ERROR,
            "No interfaces found for componment core codec.\n");
        goto fail;
    }

    ret = cix_load_dsp_api(dsp_if->avctx, comp_query_interface, &dsp_if->dsp_api);
    if (ret < 0) {
        av_log(dsp_if->avctx, AV_LOG_ERROR,
            "Failed to found interfaces for componment core codec.\n");
        goto fail;
    }

    wrap_version = dsp_if->dsp_api.comp_get_version();
    av_log(dsp_if->avctx, AV_LOG_INFO, "DSP API version: %s\n", wrap_version);

    return true;

fail:
    if (dsp_if->lib)
        dlclose(dsp_if->lib);

    return false;
}

bool audio_dsp_load_lib(struct cix_dsp_lib *dsp_lib)
{
    dspcomp_query_interface comp_query_interface;
    const char *wrap_version;
    dspcomp_errcode ret;

    dsp_lib->lib = dlopen(DSP_API_LIB_NAME, RTLD_LAZY | RTLD_GLOBAL);
    if (!dsp_lib->lib) {
        av_log(NULL, AV_LOG_ERROR, "dsp wrap api lib(%s) not found.\n",
            DSP_API_LIB_NAME);
        goto fail;
    }

    comp_query_interface = dlsym(dsp_lib->lib, (char *)"dsp_comp_query_interface");
    if (!comp_query_interface) {
        av_log(NULL, AV_LOG_ERROR,
            "No interfaces found for componment core codec.\n");
        goto fail;
    }

    ret = cix_load_dsp_api(NULL, comp_query_interface, &dsp_lib->dsp_api);
    if (ret < 0) {
        av_log(NULL, AV_LOG_ERROR,
            "Failed to found interfaces for componment core codec.\n");
        goto fail;
    }

    wrap_version = dsp_lib->dsp_api.comp_get_version();
    av_log(NULL, AV_LOG_INFO, "DSP API version: %s\n", wrap_version);

    return true;

fail:
    if (dsp_lib->lib)
        dlclose(dsp_lib->lib);

    return false;
}

bool audio_dsp_unload_if(struct cix_dsp_if *dsp_if)
{
    if (!dsp_if || !dsp_if->lib)
        return false;

    dlclose(dsp_if->lib);
    dsp_if->lib = NULL;

    return true;
}

static bool audio_dsp_component_allocate_buf(struct cix_dsp_if *dsp_if)
{
    struct dspcomp_param comp_param;
    dspcomp_errcode ret;

    /* get component parameter */
    comp_param.type = DSPCOMP_PARAM_INBUF_SIZE;
    ret = dsp_if->dsp_api.comp_get_param(dsp_if->dsp_comp, &comp_param);
    if (ret < 0)
        goto fail;
    dsp_if->inbuf_size = comp_param.value;

    comp_param.type = DSPCOMP_PARAM_OUTBUF_SIZE;
    ret = dsp_if->dsp_api.comp_get_param(dsp_if->dsp_comp, &comp_param);
    if (ret < 0)
        goto fail;
    dsp_if->outbuf_size = comp_param.value;

    /* allocate buffer */
    if (dsp_if->inbuf_size) {
        dsp_if->p_inbuf = (unsigned char *)av_mallocz(dsp_if->inbuf_size);
        if (!dsp_if->p_inbuf) {
            av_log(dsp_if->avctx, AV_LOG_ERROR, "allocate input buffer failed\n");
            goto fail;
        }
    }

    if (dsp_if->outbuf_size) {
        dsp_if->p_outbuf = (unsigned char *)av_mallocz(dsp_if->outbuf_size);
        if (!dsp_if->p_outbuf) {
            av_log(dsp_if->avctx, AV_LOG_ERROR, "allocate output buffer failed\n");
            goto fail;
        }
    }

    av_log(dsp_if->avctx, AV_LOG_INFO,
        "allocate buffer, inbuf_size:%d, p_inbuf:%p, outbuf_size:%d, p_outbuf:%p\n",
        dsp_if->inbuf_size, dsp_if->p_inbuf,
        dsp_if->outbuf_size, dsp_if->p_outbuf);

    return true;

fail:
    av_log(dsp_if->avctx, AV_LOG_ERROR,
        "exit audio_dsp_component_allocate_buf, failed\n");
    if (dsp_if->p_inbuf)
        av_freep(&dsp_if->p_inbuf);
    if (dsp_if->p_outbuf)
        av_freep(&dsp_if->p_outbuf);

    return false;
}

static void audio_dsp_component_free_buf(struct cix_dsp_if *dsp_if)
{
    if (dsp_if->p_inbuf)
        av_freep(&dsp_if->p_inbuf);
    if (dsp_if->p_outbuf)
        av_freep(&dsp_if->p_outbuf);
}

static void audio_dsp_component_info_reset(struct cix_dsp_if *dsp_if)
{
    dsp_if->total_input = 0;
    dsp_if->total_output = 0;
    dsp_if->samples_per_frame = 0;
    dsp_if->param_updated = false;
}

bool audio_dsp_component_create(struct cix_dsp_if *dsp_if,
    dspcomp_opcode opcode,
    dspcomp_format format)
{
  struct dspcomp_config comp_config;
  dspcomp_errcode ret;

  comp_config.opcode = opcode;
  comp_config.format = format;
  comp_config.num_input_buf = 1;
  comp_config.num_output_buf = 1;
  ret = dsp_if->dsp_api.comp_create(&dsp_if->dsp_comp, &comp_config);
  if (ret < 0) {
    av_log(dsp_if->avctx, AV_LOG_ERROR, "create dsp component failed.\n");
    return false;
  }
  dsp_if->opcode = opcode;

  audio_dsp_component_info_reset(dsp_if);

  return audio_dsp_component_allocate_buf(dsp_if);
}

void audio_dsp_component_delete(struct cix_dsp_if *dsp_if)
{
    char name[16];

    if (dsp_if->opcode == DSPCOMP_OPCODE_DECODER)
        snprintf(name, sizeof(name), "decoder");
    else if (dsp_if->opcode == DSPCOMP_OPCODE_ENCODER)
        snprintf(name, sizeof(name), "encoder");
    else if (dsp_if->opcode == DSPCOMP_OPCODE_MIXER)
        snprintf(name, sizeof(name), "mixer");

    av_log(dsp_if->avctx, AV_LOG_INFO,
        "finished %s processing, total input:%d. total output:%d\n",
        name, dsp_if->total_input, dsp_if->total_output);

    audio_dsp_component_free_buf(dsp_if);
    dsp_if->dsp_api.comp_delete(dsp_if->dsp_comp);
}

int audio_dsp_component_handle_frame_decoder(struct cix_dsp_if *dsp_if)
{
    AVCodecContext *avctx = dsp_if->avctx;
    AVPacket *avpkt       = dsp_if->pkt;
    AVFrame *frame        = dsp_if->frame;
    uint8_t *samples      = frame->data[0];
    uint8_t *src          = avpkt->data;
    int buf_size          = avpkt->size;
    int input_size, input_pos;
    int input_consumed, decoded_bytes, ct_decoded_bytes;
    int state;
    dspcomp_errcode ret;

    /* Try to decode the input data by dsp */
    input_size = buf_size;
    input_pos = 0;
    decoded_bytes = 0;
    ct_decoded_bytes = 0;
    do {
        ret =
            dsp_if->dsp_api.
            comp_process_frame_out_disconnect_sync(dsp_if->dsp_comp,
            src + input_pos, input_size - input_pos, &input_consumed,
            &dsp_if->p_outbuf, &decoded_bytes, &state);

        if (ret < 0) {
            av_log(avctx, AV_LOG_ERROR,
                "dsp comp_process_frame_out_disconnect_sync failed, ret:%d\n", ret);
            break;
        }
        input_pos += input_consumed;
        if (input_consumed)
            dsp_if->total_input += input_consumed;

        if (state == DSPCOMP_STATE_OUTPUT_READY) {
            memcpy(samples + ct_decoded_bytes, dsp_if->p_outbuf, decoded_bytes);

            dsp_if->total_output += decoded_bytes;
            ct_decoded_bytes += decoded_bytes;
        } else if (state == DSPCOMP_STATE_OUTPUT_INITED) {
            struct dspcomp_param param;

            param.type = DSPCOMP_PARAM_SAMPLERATE;
            ret = dsp_if->dsp_api.comp_get_param(dsp_if->dsp_comp, &param);
            if (ret < 0) {
                av_log(avctx, AV_LOG_ERROR, "get sample rate failed, ret = %d\n", ret);
                dsp_if->sample_rate = -1;
            } else {
                dsp_if->sample_rate = param.value;
            }

            param.type = DSPCOMP_PARAM_CHANNEL;
            ret = dsp_if->dsp_api.comp_get_param(dsp_if->dsp_comp, &param);
            if (ret < 0) {
                av_log(avctx, AV_LOG_ERROR, "get channel number failed, ret = %d\n", ret);
                dsp_if->channels = -1;
            } else {
                dsp_if->channels = param.value;
            }

            param.type = DSPCOMP_PARAM_WIDTH;
            ret = dsp_if->dsp_api.comp_get_param(dsp_if->dsp_comp, &param);
            if (ret < 0) {
                av_log(avctx, AV_LOG_ERROR, "get bit width failed, ret = %d\n", ret);
                dsp_if->width = -1;
            } else {
                dsp_if->width = param.value;
            }

            av_log(avctx, AV_LOG_INFO,
                "update paramers, sample rate:%d, channel num:%d, bit width %d\n",
                dsp_if->sample_rate,
                dsp_if->channels,
                dsp_if->width);

            dsp_if->param_updated = true;
        } else if (state == DSPCOMP_STATE_OUTPUT_DONE) {
            break;
        }

        if (input_size && (input_pos >= input_size)) {
            av_log(avctx, AV_LOG_DEBUG, "input_pos:%d, input_size:%d, dsp decoder state:%d\n",
                input_pos,
                input_size,
                state);
            break;
        }
    } while (1);

    av_log(dsp_if->avctx, AV_LOG_DEBUG,
        "state:%d, input frames:%d, current total decoded bytes:%d\n",
        state,
        input_size,
        ct_decoded_bytes);

    return ct_decoded_bytes;
}

int audio_dsp_component_handle_frame_encoder(struct cix_dsp_if *dsp_if)
{
    AVCodecContext *avctx = dsp_if->avctx;
    AVPacket *avpkt       = dsp_if->pkt;
    AVFrame *frame        = dsp_if->frame;
    uint8_t *samples      = frame->data[0];
    uint8_t *dst          = avpkt->data;
    int buf_size          = avpkt->size;
    int input_size, input_pos;
    int input_consumed, encoded_bytes, ct_encoded_bytes;
    int state;
    dspcomp_errcode ret;

    /* Try to encode the input data by dsp */
    input_size = buf_size;
    input_pos = 0;
    encoded_bytes = 0;
    ct_encoded_bytes = 0;
    do {
        ret =
            dsp_if->dsp_api.
            comp_process_frame_out_disconnect_sync(dsp_if->dsp_comp,
            samples + input_pos, input_size - input_pos, &input_consumed,
            &dsp_if->p_outbuf, &encoded_bytes, &state);
        if (ret < 0) {
            av_log(avctx, AV_LOG_ERROR,
                "dsp comp_process_frame_out_disconnect_sync failed");
            break;
        }
        input_pos += input_consumed;
        if (input_consumed)
            dsp_if->total_input += input_consumed;

        if (state == DSPCOMP_STATE_OUTPUT_READY) {
            memcpy(dst + ct_encoded_bytes, dsp_if->p_outbuf, encoded_bytes);

            dsp_if->total_output += encoded_bytes;
            ct_encoded_bytes += encoded_bytes;
        } else if (state == DSPCOMP_STATE_OUTPUT_INITED) {

        } else if (state == DSPCOMP_STATE_OUTPUT_DONE) {
            break;
        }

        if (input_size && (input_pos >= input_size)) {
            break;
        }
    } while (1);

    return ct_encoded_bytes;
}

int audio_dsp_component_flush(struct cix_dsp_if *dsp_if)
{
    return dsp_if->dsp_api.comp_flush(dsp_if->dsp_comp);
}

void audio_dsp_component_set_format(struct cix_dsp_if *dsp_if, struct dsp_format *fmt)
{
    struct dspcomp_param comp_param[6];
    dspcomp_errcode ret;
    unsigned int i = 0;

    /* set format parameter */
    if (fmt->sample_rate > 0) {
        av_log(dsp_if->avctx, AV_LOG_WARNING, "Set sample_rate = %d\n", fmt->sample_rate);
        comp_param[i].type = DSPCOMP_PARAM_SAMPLERATE;
        comp_param[i].value = fmt->sample_rate;
        i++;
    }

    if (fmt->channels > 0) {
        av_log(dsp_if->avctx, AV_LOG_WARNING, "Set channels = %d\n", fmt->channels);
        comp_param[i].type = DSPCOMP_PARAM_CHANNEL;
        comp_param[i].value = fmt->channels;
        i++;
    }

    if (fmt->width > 0) {
        av_log(dsp_if->avctx, AV_LOG_WARNING, "Set witdh = %d\n", fmt->width);
        comp_param[i].type = DSPCOMP_PARAM_WIDTH;
        comp_param[i].value = fmt->width;
        i++;
    }

    if (fmt->bitrate > 0) {
        av_log(dsp_if->avctx, AV_LOG_WARNING, "Set bitrate = %d\n", fmt->bitrate);
        comp_param[i].type = DSPCOMP_PARAM_BITRATE;
        comp_param[i].value = fmt->bitrate;
        i++;
    }

    if (fmt->audobjtype > 0) {
        av_log(dsp_if->avctx, AV_LOG_WARNING, "Set audobjtype = %d\n", fmt->audobjtype);
        comp_param[i].type = DSPCOMP_PARAM_AUDOBJTYPE;
        comp_param[i].value = fmt->audobjtype;
        i++;
    }

    if (fmt->bsformat > 0) {
        av_log(dsp_if->avctx, AV_LOG_WARNING, "Set bsformat = %d\n", fmt->bsformat);
        comp_param[i].type = DSPCOMP_PARAM_BSFORMAT;
        comp_param[i].value = fmt->bsformat;
        i++;
    }

    if (i > 0) {
        ret = dsp_if->dsp_api.comp_set_param(dsp_if->dsp_comp, i, comp_param);
        if (ret < 0) {
        av_log(dsp_if->avctx, AV_LOG_ERROR, "failed to set params.\n");
        return;
        }
    }
}
