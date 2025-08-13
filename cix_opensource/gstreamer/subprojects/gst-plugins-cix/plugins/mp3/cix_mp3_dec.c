/* CIX MP3 Decoder
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

/**
 * SECTION: element-cixmp3dec
 * @title: cixmp3dec
 *
 * Audio decoder for MPEG-1 layer 1/2/3 audio data with hifi
 *
 * ## Example pipelines
 *
 * |[
 * gst-launch-1.0 filesrc location=music.mp3 ! mpegaudioparse ! cixmp3dec ! filesink location=music.pcm
 * ]| Decode the mp3 file and save to file
 *
 * |[
 * gst-launch-1.0 filesrc location=music.mp3 ! mpegaudioparse ! cixmp3dec ! audioconvert ! audioresample ! autoaudiosink
 * ]| Decode and play the mp3 file
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gst/gst.h>
#include <gst/tag/tag.h>

#include "cix_mp3_dec.h"

static GstStaticPadTemplate src_template = GST_STATIC_PAD_TEMPLATE ("src",
    GST_PAD_SRC,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS ("audio/x-raw, "
        "format = (string) " GST_AUDIO_NE (S16) ", "
        "layout = (string) interleaved, "
        "rate = (int) { 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000 }, "
        "channels = (int) 1; "
        "audio/x-raw, "
        "format = (string) " GST_AUDIO_NE (S16) ", "
        "layout = (string) interleaved, "
        "rate = (int) { 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000 }, "
        "channels = (int) 2, " "channel-mask = (bitmask) 0x3")
    );

static GstStaticPadTemplate sink_template = GST_STATIC_PAD_TEMPLATE ("sink",
    GST_PAD_SINK,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS ("audio/mpeg, "
        "mpegversion = (int) 1, "
        "layer = (int) [ 1, 3 ], "
        "rate = (int) { 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000 }, "
        "channels = (int) [ 1, 2 ], " "parsed = (boolean) true ")
    );

GST_DEBUG_CATEGORY_STATIC (gst_cix_mp3_dec_debug);
#define GST_CAT_DEFAULT gst_cix_mp3_dec_debug

#define gst_cix_mp3_dec_parent_class parent_class
G_DEFINE_TYPE (GstCixMP3Dec, gst_cix_mp3_dec, GST_TYPE_AUDIO_DECODER);
GST_ELEMENT_REGISTER_DEFINE (cixmp3dec, "cixmp3dec",
    GST_RANK_MARGINAL, GST_TYPE_CIX_MP3_DEC);

static void gst_cix_mp3_dec_finalize (GObject * object);
static gboolean gst_cix_mp3_dec_start (GstAudioDecoder * decoder);
static gboolean gst_cix_mp3_dec_stop (GstAudioDecoder * decoder);
static GstFlowReturn gst_cix_mp3_dec_handle_frame (GstAudioDecoder * decoder,
    GstBuffer * buffer);
static void gst_cix_mp3_dec_flush (GstAudioDecoder * decoder, gboolean hard);
static gboolean gst_cix_mp3_dec_set_format (GstAudioDecoder * decoder,
    GstCaps * caps);

static void
gst_cix_mp3_dec_class_init (GstCixMP3DecClass * klass)
{
  GObjectClass *object_class = G_OBJECT_CLASS (klass);
  GstElementClass *element_class = GST_ELEMENT_CLASS (klass);
  GstAudioDecoderClass *base_class = GST_AUDIO_DECODER_CLASS (klass);

  object_class->finalize = gst_cix_mp3_dec_finalize;

  base_class->start = GST_DEBUG_FUNCPTR (gst_cix_mp3_dec_start);
  base_class->stop = GST_DEBUG_FUNCPTR (gst_cix_mp3_dec_stop);
  base_class->handle_frame = GST_DEBUG_FUNCPTR (gst_cix_mp3_dec_handle_frame);
  base_class->flush = GST_DEBUG_FUNCPTR (gst_cix_mp3_dec_flush);
  base_class->set_format = GST_DEBUG_FUNCPTR (gst_cix_mp3_dec_set_format);

  gst_element_class_add_static_pad_template (element_class, &sink_template);
  gst_element_class_add_static_pad_template (element_class, &src_template);

  gst_element_class_set_static_metadata (element_class,
      "cix mp3 decoder", "Codec/Decoder/Audio",
      "decode mp3 stream to pcm audio", "Cix Tech.");

  GST_DEBUG_CATEGORY_INIT (gst_cix_mp3_dec_debug, "cixmp3dec", 0,
      "cix mp3 decoder");
}

static void
gst_cix_mp3_dec_init (GstCixMP3Dec * dec)
{
  dec->dsp_if = (struct cix_dsp_if *) g_malloc0 (sizeof (struct cix_dsp_if));
  if (!dec->dsp_if) {
    GST_ERROR ("No memory to malloc0 for dsp interface.");
    return;
  }
  dec->dsp_if->obj = (gpointer *) dec;

  if (audio_dsp_load_if (dec->dsp_if) == FALSE) {
    return;
  }

  gst_audio_decoder_set_needs_format (GST_AUDIO_DECODER (dec), TRUE);
  gst_audio_decoder_set_use_default_pad_acceptcaps (GST_AUDIO_DECODER_CAST
      (dec), TRUE);
  GST_PAD_SET_ACCEPT_TEMPLATE (GST_AUDIO_DECODER_SINK_PAD (dec));
}

static void
gst_cix_mp3_dec_finalize (GObject * object)
{
  GstCixMP3Dec *dec = GST_CIX_MP3_DEC (object);

  audio_dsp_unload_if (dec->dsp_if);
  free (dec->dsp_if);

  G_OBJECT_CLASS (parent_class)->finalize (object);
}

static gboolean
gst_cix_mp3_dec_start (GstAudioDecoder * decoder)
{
  GstCixMP3Dec *dec = GST_CIX_MP3_DEC (decoder);

  audio_dsp_component_create (dec->dsp_if, DSPCOMP_OPCODE_DECODER,
      DSPCOMP_FMT_MP3);

  return TRUE;
}

static gboolean
gst_cix_mp3_dec_stop (GstAudioDecoder * decoder)
{
  GstCixMP3Dec *dec = GST_CIX_MP3_DEC (decoder);

  audio_dsp_component_delete (dec->dsp_if);

  return TRUE;
}

static GstFlowReturn
gst_cix_mp3_dec_handle_frame (GstAudioDecoder * decoder, GstBuffer * buffer)
{
  GstCixMP3Dec *dec = GST_CIX_MP3_DEC (decoder);

  return audio_dsp_component_handle_frame_decoder (dec->dsp_if, decoder,
      buffer);
}

static void
gst_cix_mp3_dec_flush (GstAudioDecoder * decoder, gboolean hard)
{
  GstCixMP3Dec *dec = GST_CIX_MP3_DEC (decoder);

  audio_dsp_component_flush_decoder (dec->dsp_if, decoder);
}

static gboolean
gst_cix_mp3_dec_set_format (GstAudioDecoder * decoder, GstCaps * caps)
{
  GstCixMP3Dec *dec = GST_CIX_MP3_DEC (decoder);
  int sample_rate, num_channels, width;
  GstAudioFormat format;
  gboolean ret = TRUE;

  GST_DEBUG_OBJECT (dec, "set_format: New caps %" GST_PTR_FORMAT "", caps);

  /* Get sample rate and number of channels from input_caps */
  {
    GstStructure *structure;
    gboolean err = FALSE;

    /* Only the first structure is used (multiple
     * input caps structures don't make sense */
    structure = gst_caps_get_structure (caps, 0);

    if (!gst_structure_get_int (structure, "rate", &sample_rate)) {
      err = TRUE;
      GST_ERROR_OBJECT (dec, "Input caps do not have a rate value");
    }
    if (!gst_structure_get_int (structure, "channels", &num_channels)) {
      err = TRUE;
      GST_ERROR_OBJECT (dec, "Input caps do not have a channel value");
    }

    if (G_UNLIKELY (err))
      GST_ERROR_OBJECT (dec, "Input caps error:%d", err);
  }
  /* Get sample format from the allowed src caps */
  {
    GstCaps *allowed_srccaps =
        gst_pad_get_allowed_caps (GST_AUDIO_DECODER_SRC_PAD (dec));
    GValue const *format_value;
    gchar const *format_str;

    /* Look at the sample format values from the first structure */
    GstStructure *structure = gst_caps_get_structure (allowed_srccaps, 0);
    format_value = gst_structure_get_value (structure, "format");
    format_str = g_value_get_string (format_value);
    format = gst_audio_format_from_string (format_str);
  }

  gst_audio_info_set_format (&(dec->audioinfo), format,
      sample_rate, num_channels, NULL);
  gst_audio_decoder_set_output_format (decoder, &dec->audioinfo);

  switch (format) {
    case GST_AUDIO_FORMAT_S16:
      width = 16;
      break;
    case GST_AUDIO_FORMAT_S24:
      width = 24;
      break;
    case GST_AUDIO_FORMAT_S32:
      width = 32;
      break;
    default:
      width = 16;
      break;
  }

  GST_INFO_OBJECT (dec, "The next audio format is: %s, %u Hz, %u channels",
      gst_audio_format_to_string (format), sample_rate, num_channels);

  return ret;
}

static gboolean
plugin_init (GstPlugin * plugin)
{
  return GST_ELEMENT_REGISTER (cixmp3dec, plugin);
}

GST_PLUGIN_DEFINE (GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    cixmp3dec,
    "CIX MP3 Decoder",
    plugin_init, VERSION, "LGPL", GST_PACKAGE_NAME, GST_PACKAGE_ORIGIN);
