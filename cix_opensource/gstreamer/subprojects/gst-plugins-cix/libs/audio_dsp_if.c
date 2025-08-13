/* AUDIO DSP INTERFACE
 * Copyright 2024 Cix Technology Group Co., Ltd.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */
#include <dlfcn.h>
#include "audio_dsp_if.h"

#define DSP_API_LIB_NAME "libdsp_wrap.so"

static dspcomp_errcode
cix_load_dsp_api (gpointer * obj, dspcomp_query_interface comp_query_interface,
    struct dsp_comp_interface *interface)
{
  dspcomp_errcode ret;

  ret = comp_query_interface (API_DSPCOMP_GET_VERSION,
      (void **) &(interface->comp_get_version));
  if (ret < 0) {
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_GET_VERSION failed, ret = %d\n", ret);
    return ret;
  }
  ret = comp_query_interface (API_DSPCOMP_CREATE,
      (void **) &(interface->comp_create));
  if (ret < 0) {
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_CREATE failed, ret = %d\n", ret);
    return ret;
  }
  ret = comp_query_interface (API_DSPCOMP_DELETE,
      (void **) &(interface->comp_delete));
  if (ret < 0) {
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_DELETE failed, ret = %d\n", ret);
    return ret;
  }
  ret = comp_query_interface (API_DSPCOMP_FLUSH,
      (void **) &(interface->comp_flush));
  if (ret < 0) {
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_FLUSH failed, ret = %d\n", ret);
    return ret;
  }
  ret = comp_query_interface (API_DSPCOMP_GET_PARAM,
      (void **) &(interface->comp_get_param));
  if (ret < 0) {
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_GET_PARAM failed, ret = %d\n", ret);
    return ret;
  }
  ret = comp_query_interface (API_DSPCOMP_SET_PARAM,
      (void **) &(interface->comp_set_param));
  if (ret < 0) {
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_SET_PARAM failed, ret = %d\n", ret);
    return ret;
  }
  ret = comp_query_interface (API_DSPCOMP_PROCESS_FRAME_OUT_DISCONNECT_SYNC,
      (void **) &(interface->comp_process_frame_out_disconnect_sync));
  if (ret < 0)
    GST_ERROR_OBJECT (obj,
        "query interface: API_DSPCOMP_PROCESS_FRAME_OUT_DISCONNECT_SYNC failed, ret = %d\n",
        ret);

  return ret;
}

gboolean
audio_dsp_load_if (struct cix_dsp_if *dsp_if)
{
  dspcomp_query_interface comp_query_interface;
  const gchar *wrap_version;
  dspcomp_errcode ret;

  dsp_if->lib = dlopen (DSP_API_LIB_NAME, RTLD_NOW | RTLD_GLOBAL);
  if (!dsp_if->lib) {
    GST_ERROR_OBJECT (dsp_if->obj, "dsp wrap api lib(%s) not found.",
        DSP_API_LIB_NAME);
    goto fail;
  }

  comp_query_interface =
      dlsym (dsp_if->lib, (gchar *) "dsp_comp_query_interface");
  if (!comp_query_interface) {
    GST_ERROR_OBJECT (dsp_if->obj,
        "No interfaces found for componment core codec");
    goto fail;
  }

  ret = cix_load_dsp_api (dsp_if->obj, comp_query_interface, &dsp_if->dsp_api);
  if (ret < 0) {
    GST_ERROR_OBJECT (dsp_if->obj,
        "Failed to found interfaces for componment core codec");
    goto fail;
  }

  wrap_version = dsp_if->dsp_api.comp_get_version ();
  GST_INFO_OBJECT (dsp_if->obj, "DSP API version: %s", wrap_version);

  return TRUE;

fail:
  if (dsp_if->lib)
    dlclose (dsp_if->lib);

  return FALSE;
}

gboolean
audio_dsp_unload_if (struct cix_dsp_if *dsp_if)
{
  if (G_UNLIKELY (!dsp_if) || G_UNLIKELY (!dsp_if->lib))
    return FALSE;

  dlclose (dsp_if->lib);

  return TRUE;
}

static gboolean
audio_dsp_component_allocate_buf (struct cix_dsp_if *dsp_if)
{
  struct dspcomp_param comp_param;
  dspcomp_errcode ret;

  /* get component parameter */
  comp_param.type = DSPCOMP_PARAM_INBUF_SIZE;
  ret = dsp_if->dsp_api.comp_get_param (dsp_if->dsp_comp, &comp_param);
  if (ret < 0) {
    goto fail;
  }
  dsp_if->inbuf_size = comp_param.value;

  comp_param.type = DSPCOMP_PARAM_OUTBUF_SIZE;
  ret = dsp_if->dsp_api.comp_get_param (dsp_if->dsp_comp, &comp_param);
  if (ret < 0) {
    goto fail;
  }
  dsp_if->outbuf_size = comp_param.value;

  GST_INFO_OBJECT (dsp_if->obj,
      "allocate buffer, inbuf_size:%d, outbuf_size:%d\n",
      dsp_if->inbuf_size, dsp_if->outbuf_size);

  /* allocate input and output buffer */
  if (dsp_if->inbuf_size) {
    dsp_if->p_inbuf = (unsigned char *) g_malloc0 (dsp_if->inbuf_size);
    if (!dsp_if->p_inbuf) {
      GST_ERROR_OBJECT (dsp_if->obj, "allocate input buffer failed\n");
      goto fail;
    }
  }
  if (dsp_if->outbuf_size) {
    dsp_if->p_outbuf = (unsigned char *) g_malloc0 (dsp_if->outbuf_size);
    if (!dsp_if->p_outbuf) {
      GST_ERROR_OBJECT (dsp_if->obj, "allocate output buffer failed\n");
      goto fail;
    }
  }

  return TRUE;

fail:
  if (dsp_if->p_outbuf)
    free (dsp_if->p_outbuf);
  if (dsp_if->p_inbuf)
    free (dsp_if->p_inbuf);

  return FALSE;
}

static void
audio_dsp_component_free_buf (struct cix_dsp_if *dsp_if)
{
  if (dsp_if->p_outbuf)
    free (dsp_if->p_outbuf);
  if (dsp_if->p_inbuf)
    free (dsp_if->p_inbuf);
}

static void
audio_dsp_component_info_reset (struct cix_dsp_if *dsp_if)
{
  dsp_if->total_input = 0;
  dsp_if->total_output = 0;
  dsp_if->samples_per_frame = 0;
  dsp_if->param_updated = FALSE;
}

gboolean
audio_dsp_component_create (struct cix_dsp_if *dsp_if, dspcomp_opcode opcode,
    dspcomp_format format)
{
  struct dspcomp_config comp_config;
  dspcomp_errcode ret;

  comp_config.opcode = opcode;
  comp_config.format = format;
  comp_config.num_input_buf = 1;
  comp_config.num_output_buf = 1;
  ret = dsp_if->dsp_api.comp_create (&dsp_if->dsp_comp, &comp_config);
  if (ret < 0) {
    GST_ERROR_OBJECT (dsp_if->obj, "create dsp component failed.");
    return FALSE;
  }

  audio_dsp_component_info_reset (dsp_if);

  return audio_dsp_component_allocate_buf (dsp_if);
}

void
audio_dsp_component_delete (struct cix_dsp_if *dsp_if)
{
  GST_INFO_OBJECT (dsp_if->obj,
      "finished processing, total input:%d. total output:%d",
      dsp_if->total_input, dsp_if->total_output);

  audio_dsp_component_free_buf (dsp_if);
  dsp_if->dsp_api.comp_delete (dsp_if->dsp_comp);
}

GstFlowReturn
audio_dsp_component_flush_decoder (struct cix_dsp_if *dsp_if,
    GstAudioDecoder * decoder)
{
  dsp_if->dsp_api.comp_flush (dsp_if->dsp_comp);
  return gst_audio_decoder_finish_frame (decoder, NULL, 1);
}

GstFlowReturn
audio_dsp_component_flush_encoder (struct cix_dsp_if *dsp_if,
    GstAudioEncoder * encoder)
{
  dsp_if->dsp_api.comp_flush (dsp_if->dsp_comp);
  return gst_audio_encoder_finish_frame (encoder, NULL,
      dsp_if->samples_per_frame);
}

GstFlowReturn
audio_dsp_component_handle_frame_decoder (struct cix_dsp_if *dsp_if,
    GstAudioDecoder * decoder, GstBuffer * buffer)
{
  GstMapInfo map;
  GstBuffer *output_buffer;
  gsize input_size, input_pos;
  guint input_consumed, decoded_bytes;
  guint state;
  dspcomp_errcode ret;

  if (GST_IS_BUFFER (buffer)) {
    gst_buffer_map (buffer, &map, GST_MAP_READ);
  } else {
    map.data = NULL;
    map.size = 0;
  }
  input_size = map.size;

  GST_DEBUG_OBJECT (dsp_if->obj, "Received buffer of size %" G_GSIZE_FORMAT,
      input_size);

  /* Try to decode a frame by dsp */
  input_pos = 0;
  do {
    /* input audio data, and decoder output data */
    ret =
        dsp_if->dsp_api.
        comp_process_frame_out_disconnect_sync (dsp_if->dsp_comp,
        map.data + input_pos, input_size - input_pos, &input_consumed,
        &dsp_if->p_outbuf, &decoded_bytes, &state);
    if (ret < 0) {
      GST_ERROR_OBJECT (dsp_if->obj,
          "dsp comp_process_frame_out_disconnect_sync failed");
      break;
    }
    input_pos += input_consumed;
    if (input_consumed)
      dsp_if->total_input += input_consumed;

    if (state == DSPCOMP_STATE_OUTPUT_READY) {
      output_buffer = gst_buffer_new_allocate (NULL, decoded_bytes, NULL);
      if (output_buffer) {
        GstMapInfo info;
        if (gst_buffer_map (output_buffer, &info, GST_MAP_WRITE)) {
          memcpy (info.data, dsp_if->p_outbuf, decoded_bytes);
          gst_buffer_unmap (output_buffer, &info);
        } else {
          GST_ERROR_OBJECT (dsp_if->obj, "gst_buffer_map() returned NULL");
          gst_buffer_unref (output_buffer);
          output_buffer = NULL;
        }
        gst_audio_decoder_finish_frame (decoder, output_buffer, 1);
      } else {
        GST_ERROR_OBJECT (dsp_if->obj, "NULL memory, decoded_bytes:%d",
            decoded_bytes);
        /* This is necessary to advance playback in time,
         * even when nothing was decoded.
         */
        gst_audio_decoder_finish_frame (decoder, NULL, 1);
      }
      dsp_if->total_output += decoded_bytes;
    } else if (state == DSPCOMP_STATE_OUTPUT_INITED) {
      struct dspcomp_param param;

      param.type = DSPCOMP_PARAM_SAMPLERATE;
      ret = dsp_if->dsp_api.comp_get_param (dsp_if->dsp_comp, &param);
      if (ret < 0) {
        GST_ERROR_OBJECT (dsp_if->obj, "get sample rate failed, ret = %d\n",
            ret);
        dsp_if->sample_rate = -1;
      } else {
        dsp_if->sample_rate = param.value;
      }

      param.type = DSPCOMP_PARAM_CHANNEL;
      ret = dsp_if->dsp_api.comp_get_param (dsp_if->dsp_comp, &param);
      if (ret < 0) {
        GST_ERROR_OBJECT (dsp_if->obj, "get channel number failed, ret = %d\n",
            ret);
        dsp_if->channels = -1;
      } else {
        dsp_if->channels = param.value;
      }

      param.type = DSPCOMP_PARAM_WIDTH;
      ret = dsp_if->dsp_api.comp_get_param (dsp_if->dsp_comp, &param);
      if (ret < 0) {
        GST_ERROR_OBJECT (dsp_if->obj, "get bit width failed, ret = %d\n", ret);
        dsp_if->width = -1;
      } else {
        dsp_if->width = param.value;
      }

      GST_INFO_OBJECT (dsp_if->obj,
          "update paramers, sample rate:%d, channel num:%d, bit width %d\n",
          dsp_if->sample_rate, dsp_if->channels, dsp_if->width);

      dsp_if->param_updated = TRUE;
    } else if (state == DSPCOMP_STATE_OUTPUT_DONE) {
      audio_dsp_component_flush_decoder (dsp_if, decoder);
      break;
    }
    if (input_size && (input_pos >= input_size)) {
      break;
    }
  } while (1);

  if (GST_IS_BUFFER (buffer))
    gst_buffer_unmap (buffer, &map);

  return GST_FLOW_OK;
}

GstFlowReturn
audio_dsp_component_handle_frame_encoder (struct cix_dsp_if *dsp_if,
    GstAudioEncoder * encoder, GstBuffer * buffer)
{
  GstFlowReturn err = GST_FLOW_OK;
  GstMapInfo map;
  GstBuffer *output_buffer;
  gsize input_size, input_pos;
  guint input_consumed, encoded_bytes;
  guint state;
  dspcomp_errcode ret;

  if (GST_IS_BUFFER (buffer)) {
    gst_buffer_map (buffer, &map, GST_MAP_READ);
  } else {
    map.data = NULL;
    map.size = 0;
  }
  input_size = map.size;

  GST_INFO_OBJECT (dsp_if->obj, "Received buffer of size %" G_GSIZE_FORMAT,
      input_size);

  /* Try to encode a frame by dsp */
  input_pos = 0;
  do {
    /* input audio data, and encoder output data */
    ret =
        dsp_if->dsp_api.
        comp_process_frame_out_disconnect_sync (dsp_if->dsp_comp,
        map.data + input_pos, input_size - input_pos, &input_consumed,
        &dsp_if->p_outbuf, &encoded_bytes, &state);
    if (ret < 0) {
      GST_ERROR_OBJECT (dsp_if->obj,
          "dsp comp_process_frame_out_disconnect_sync failed");
      err = GST_FLOW_ERROR;
      break;
    }

    if (map.size)
      input_pos += input_consumed;
    if (input_consumed)
      dsp_if->total_input += input_consumed;

    if (state == DSPCOMP_STATE_OUTPUT_READY) {
      output_buffer = gst_buffer_new_allocate (NULL, encoded_bytes, NULL);

      if (output_buffer) {
        GstMapInfo info;
        if (gst_buffer_map (output_buffer, &info, GST_MAP_WRITE)) {
          memcpy (info.data, dsp_if->p_outbuf, encoded_bytes);
          gst_buffer_unmap (output_buffer, &info);
        } else {
          GST_WARNING_OBJECT (dsp_if->obj, "gst_buffer_map() returned NULL");
          gst_buffer_unref (output_buffer);
          output_buffer = NULL;
        }

        err = gst_audio_encoder_finish_frame (encoder, output_buffer,
            dsp_if->samples_per_frame);
      } else {
        GST_WARNING_OBJECT (dsp_if->obj,
            "gst_buffer_new_allocate() returned NULL");

        err = gst_audio_encoder_finish_frame (encoder, NULL,
            dsp_if->samples_per_frame);
      }

      if (err < 0) {
        GST_ERROR_OBJECT (dsp_if->obj, "encoded failed");
        break;
      }
      dsp_if->total_output += encoded_bytes;
    }

    if (state == DSPCOMP_STATE_OUTPUT_DONE) {
      /* Pass NULL buffer here, in order to change "got_data"
       * from TRUE to FALSE, which caused by residual data output
       * from dsp, so that gst_audio_encoder_push_buffers() can
       * bail out the encoding loop when finish encoding EoS frame.
       */
      err = gst_audio_encoder_finish_frame (encoder, NULL, -1);
      if (err < 0)
        GST_ERROR_OBJECT (dsp_if->obj, "encoded failed");
      break;
    }

    if (input_size && (input_pos >= input_size)) {
      break;
    }
  } while (1);

  if (GST_IS_BUFFER (buffer))
    gst_buffer_unmap (buffer, &map);

  return err;
}

void
audio_dsp_component_set_format (struct cix_dsp_if *dsp_if,
    struct dsp_format *fmt)
{
  struct dspcomp_param comp_param[6];
  dspcomp_errcode ret;
  guint i = 0;

  /* set format parameter */
  if (fmt->sample_rate > 0) {
    GST_INFO_OBJECT (dsp_if->obj, "Set sample_rate = %d", fmt->sample_rate);
    comp_param[i].type = DSPCOMP_PARAM_SAMPLERATE;
    comp_param[i].value = fmt->sample_rate;
    i++;
  }

  if (fmt->channels > 0) {
    GST_INFO_OBJECT (dsp_if->obj, "Set channels = %d", fmt->channels);
    comp_param[i].type = DSPCOMP_PARAM_CHANNEL;
    comp_param[i].value = fmt->channels;
    i++;
  }

  if (fmt->width > 0) {
    GST_INFO_OBJECT (dsp_if->obj, "Set witdh = %d", fmt->width);
    comp_param[i].type = DSPCOMP_PARAM_WIDTH;
    comp_param[i].value = fmt->width;
    i++;
  }

  if (fmt->bitrate > 0) {
    GST_INFO_OBJECT (dsp_if->obj, "Set bitrate = %d", fmt->bitrate);
    comp_param[i].type = DSPCOMP_PARAM_BITRATE;
    comp_param[i].value = fmt->bitrate;
    i++;
  }

  if (fmt->audobjtype >= 0) {
    GST_INFO_OBJECT (dsp_if->obj, "Set audobjtype = %d", fmt->audobjtype);
    comp_param[i].type = DSPCOMP_PARAM_AUDOBJTYPE;
    comp_param[i].value = fmt->audobjtype;
    i++;
  }

  if (fmt->bsformat > 0) {
    GST_INFO_OBJECT (dsp_if->obj, "Set bsformat = %d", fmt->bsformat);
    comp_param[i].type = DSPCOMP_PARAM_BSFORMAT;
    comp_param[i].value = fmt->bsformat;
    i++;
  }

  if (i > 0) {
    ret = dsp_if->dsp_api.comp_set_param (dsp_if->dsp_comp, i, comp_param);
    if (ret < 0) {
      GST_ERROR_OBJECT (dsp_if->obj, "failed to set params");
      return;
    }
  }
}
