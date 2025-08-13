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

#ifndef __AUDIO_DSP_IF_H__
#define __AUDIO_DSP_IF_H__
#include <gst/audio/audio.h>

#include "cix_dsp_api.h"

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
  gint sample_rate;
  gint channels;
  gint width;
  gint audobjtype;
  gint bsformat;
  gint bitrate;
};

/* DSP APIs */
struct cix_dsp_if
{
  gpointer *obj;

  void *lib;
  dspcomp_handle dsp_comp;
  struct dsp_comp_interface dsp_api;

  guchar *p_inbuf, *p_outbuf;
  guint inbuf_size, outbuf_size;

  guint total_input;
  guint total_output;
  guint samples_per_frame;

  /* got params from decoder/encoder */
  guint sample_rate;
  guint channels;
  guint width;
  gboolean param_updated;
};

gboolean audio_dsp_load_if (struct cix_dsp_if *dsp_if);
gboolean audio_dsp_unload_if (struct cix_dsp_if *dsp_if);

gboolean audio_dsp_component_create (struct cix_dsp_if *dsp_if,
    dspcomp_opcode opcode, dspcomp_format format);
void audio_dsp_component_delete (struct cix_dsp_if *dsp_if);

GstFlowReturn audio_dsp_component_flush_decoder (struct cix_dsp_if *dsp_if,
    GstAudioDecoder * decoder);
GstFlowReturn audio_dsp_component_flush_encoder (struct cix_dsp_if *dsp_if,
    GstAudioEncoder * encoder);

GstFlowReturn audio_dsp_component_handle_frame_decoder (struct cix_dsp_if *dsp_if,
    GstAudioDecoder * decoder, GstBuffer * buffer);
GstFlowReturn audio_dsp_component_handle_frame_encoder (struct cix_dsp_if *dsp_if,
    GstAudioEncoder * encoder, GstBuffer * buffer);

void audio_dsp_component_set_format (struct cix_dsp_if *dsp_if,
    struct dsp_format *fmt);

#endif /* __AUDIO_DSP_IF_H__ */
