/* CIX HEAACV2 Encoder
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
 * SECTION: element-cixheaacv2enc
 * @title: cixheaacv2enc
 *
 * This encoder takes PCM samples as input and outputs a
 * compressed (AAC-LC, HE-AAC v1, or HE-AAC v2) audio bitstream.
 *
 * ## Example pipelines
 *
 * |[
 * gst-launch-1.0 filesrc location=test.wav ! wavparse ! cixheaacv2enc ! "audio/mpeg,mpegversion=4,stream-format=adts,profile=he-aac-v2" ! filesink location=test.wav.aac
 * ]|
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <string.h>
#include <gst/audio/audio.h>

#include "cix_heaacv2_enc.h"

#define SAMPLE_RATES "11025, " \
                     "12000, " \
                     "16000, " \
                     "22050, " \
                     "24000, " \
                     "32000, " \
                     "44100, " \
                     "48000, "

#define SRC_CAPS \
     "audio/mpeg, " \
     "mpegversion = (int) 4, " \
     "channels = (int) { 1, 2, 5, 6 }, " \
     "rate = (int) { " SAMPLE_RATES " }, " \
     "stream-format = (string) { adts, adif }, " \
     "profile = (string) { lc, he-aac-v1, he-aac-v2 }, " \
     "framed = (boolean) true; " \
     "audio/mpeg, " \
     "mpegversion = (int) 2, " \
     "channels = (int) { 1, 2, 5, 6 }, " \
     "rate = (int) { " SAMPLE_RATES " }, " \
     "stream-format = (string) { adts, adif }, " \
     "profile = (string) { lc, he-aac-v1 }," \
     "framed = (boolean) true; "

#define SINK_CAPS \
     "audio/x-raw, " \
     "format = (string) " GST_AUDIO_NE (S16) ", " \
     "layout = (string) interleaved, " \
     "rate = (int) { " SAMPLE_RATES " }, " \
     "channels = (int) { 1, 2, 5, 6 } "

static GstStaticPadTemplate src_template = GST_STATIC_PAD_TEMPLATE ("src",
    GST_PAD_SRC,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (SRC_CAPS));

static GstStaticPadTemplate sink_template = GST_STATIC_PAD_TEMPLATE ("sink",
    GST_PAD_SINK,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (SINK_CAPS));

GST_DEBUG_CATEGORY_STATIC (gst_cix_heaacv2_enc_debug);
#define GST_CAT_DEFAULT gst_cix_heaacv2_enc_debug

/*
 * Type implementation would expand to below initialization:
 *
 * static void gst_cix_heaacv2_enc_init (GstCixHEAACV2Enc * enc);
 * static void gst_cix_heaacv2_enc_class_init (GstCixHEAACV2EncClass * klass);
 * static gpointer gst_cix_heaacv2_enc_parent_class = NULL;
 * static gint GstCixHEAACV2Enc_private_offset;
 * static void gst_cix_heaacv2_enc_class_intern_init (gpointer klass) {}
 * static inline gpointer cix_heaacv2_enc_get_instance_private (GstCixHEAACV2Enc * enc) {}
 * GType gst_cix_heaacv2_enc_get_type (void) {}
 */
G_DEFINE_TYPE (GstCixHEAACV2Enc, gst_cix_heaacv2_enc, GST_TYPE_AUDIO_ENCODER);

static gboolean
gst_cix_heaacv2_enc_start (GstAudioEncoder * encoder)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_start");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (encoder);
  gboolean ret;

  enc->dsp_if = (struct cix_dsp_if *) g_malloc0 (sizeof (struct cix_dsp_if));
  if (!enc->dsp_if) {
    GST_ERROR ("malloc dsp interface failed.");
    ret = FALSE;
    goto fail;
  }
  enc->dsp_if->obj = (gpointer *) enc;

  ret = audio_dsp_load_if (enc->dsp_if);
  if (ret != TRUE) {
    GST_ERROR ("load dsp interface failed.");
    goto fail;
  }

  ret = audio_dsp_component_create (enc->dsp_if, DSPCOMP_OPCODE_ENCODER,
      DSPCOMP_FMT_HEAACV2);
  if (ret != TRUE) {
    GST_ERROR ("create dsp component failed.");
    goto fail;
  }

  GST_INFO ("create dsp component successfully");

  return ret;

fail:
  if (enc->dsp_if)
    free (enc->dsp_if);

  return ret;
}

static gboolean
gst_cix_heaacv2_enc_stop (GstAudioEncoder * encoder)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_stop");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (encoder);

  audio_dsp_component_delete (enc->dsp_if);

  audio_dsp_unload_if (enc->dsp_if);
  free (enc->dsp_if);

  GST_INFO ("delete dsp component successfully");

  return TRUE;
}

static GstFlowReturn
gst_cix_heaacv2_enc_handle_frame (GstAudioEncoder * encoder, GstBuffer * buffer)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_handle_frame");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (encoder);

  return audio_dsp_component_handle_frame_encoder (enc->dsp_if, encoder,
      buffer);
}

static void
gst_cix_heaacv2_enc_flush (GstAudioEncoder * encoder)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_flush");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (encoder);

  audio_dsp_component_flush_encoder (enc->dsp_if, encoder);

  GST_DEBUG ("gst_cix_heaacv2_enc_flush end");
}

static gboolean
gst_cix_heaacv2_enc_set_format (GstAudioEncoder * encoder, GstAudioInfo * info)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_set_format");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (encoder);
  struct dsp_format dspfmt;
  GstCaps *allowed_caps;
  GstCaps *src_caps;
  gboolean ret = TRUE;
  gint mpegversion;
  gint samplerate = -1;
  gint channels = -1;
  gint bitwidth = -1;
  gint bitrate = -1;
  gint audobjtype = -1;
  gint bsformat = -1;

  /* Get sample rate, channel number and bit width */
  samplerate = GST_AUDIO_INFO_RATE (info);
  channels = GST_AUDIO_INFO_CHANNELS (info);
  bitwidth = GST_AUDIO_INFO_WIDTH (info);

  /* Get audio object type and bit stream format etc */
  allowed_caps = gst_pad_get_allowed_caps (GST_AUDIO_ENCODER_SRC_PAD (enc));
  GST_INFO_OBJECT (enc, "allowed caps: %" GST_PTR_FORMAT, allowed_caps);

  if (allowed_caps && gst_caps_get_size (allowed_caps) > 0) {
    GstStructure *s = gst_caps_get_structure (allowed_caps, 0);
    const gchar *str = NULL;

    if ((str = gst_structure_get_string (s, "stream-format"))) {
      if (strcmp (str, "adts") == 0) {
        GST_DEBUG_OBJECT (enc, "use ADTS format for output");
        bsformat = 2;
      } else if (strcmp (str, "adif") == 0) {
        GST_DEBUG_OBJECT (enc, "use ADIF format for output");
        bsformat = 1;
      } else {
        GST_ERROR_OBJECT (enc, "unknown stream-format: %s", str);
        return FALSE;
      }
    }

    gst_structure_get_int (s, "mpegversion", &mpegversion);

    if (mpegversion == 4) {
      if ((str = gst_structure_get_string (s, "profile"))) {
        if (strcmp (str, "lc") == 0) {
          GST_DEBUG_OBJECT (enc,
              "use MPEG-4 AAC-LC (AAC-LC) profile for output");
          audobjtype = 2;
          enc->dsp_if->samples_per_frame = 1024;
        } else if (strcmp (str, "he-aac-v1") == 0) {
          GST_DEBUG_OBJECT (enc,
              "use MPEG-4 AAC-LC with SBR (HE-AAC) profile for output");
          audobjtype = 5;
          enc->dsp_if->samples_per_frame = 2048;
        } else if (strcmp (str, "he-aac-v2") == 0) {
          GST_DEBUG_OBJECT (enc,
              "use MPEG-4 AAC-LC with SBR and PS (HE-AAC v2) profile for output");
          audobjtype = 29;
          enc->dsp_if->samples_per_frame = 2048;
        } else {
          GST_ERROR_OBJECT (enc, "unknown MPEG-4 AAC profile: %s", str);
          return FALSE;
        }
      }
    } else if (mpegversion == 2) {
      if ((str = gst_structure_get_string (s, "profile"))) {
        if (strcmp (str, "lc") == 0) {
          GST_DEBUG_OBJECT (enc,
              "use MPEG-2 AAC-LC (AAC-LC) profile for output");
          audobjtype = 129;
          enc->dsp_if->samples_per_frame = 1024;
        } else if (strcmp (str, "he-aac-v1") == 0) {
          GST_DEBUG_OBJECT (enc,
              "use MPEG-2 AAC-LC with SBR (HE-AAC) profile for output");
          audobjtype = 132;
          enc->dsp_if->samples_per_frame = 2048;
        } else {
          GST_ERROR_OBJECT (enc, "unknown MPEG-2 AAC profile: %s", str);
          return FALSE;
        }
      }
    } else {
      GST_ERROR_OBJECT (enc, "unknown MPEG version: %d", mpegversion);
      return FALSE;
    }
  }
  if (allowed_caps)
    gst_caps_unref (allowed_caps);

  bitrate = enc->bitrate;

  dspfmt.sample_rate = samplerate;
  dspfmt.channels = channels;
  dspfmt.width = bitwidth;
  dspfmt.bitrate = bitrate;
  dspfmt.audobjtype = audobjtype;
  dspfmt.bsformat = bsformat;
  audio_dsp_component_set_format (enc->dsp_if, &dspfmt);

  /* report needs to base class */
  gst_audio_encoder_set_frame_samples_min (encoder,
      enc->dsp_if->samples_per_frame);
  gst_audio_encoder_set_frame_samples_max (encoder,
      enc->dsp_if->samples_per_frame);
  gst_audio_encoder_set_frame_max (encoder, 1);

  src_caps = gst_caps_new_simple ("audio/mpeg",
      "mpegversion", G_TYPE_INT, mpegversion,
      "channels", G_TYPE_INT, channels,
      "framed", G_TYPE_BOOLEAN, TRUE, "rate", G_TYPE_INT, samplerate, NULL);

  if (bsformat == 1) {
    gst_caps_set_simple (src_caps, "stream-format", G_TYPE_STRING, "adif",
        NULL);
  } else if (bsformat == 2) {
    gst_caps_set_simple (src_caps, "stream-format", G_TYPE_STRING, "adts",
        NULL);
  }

  if (audobjtype == 2 || audobjtype == 129) {
    gst_caps_set_simple (src_caps, "profile", G_TYPE_STRING, "lc", NULL);
  } else if (audobjtype == 5 || audobjtype == 132) {
    gst_caps_set_simple (src_caps, "profile", G_TYPE_STRING, "he-aac-v1", NULL);
  } else if (audobjtype == 29) {
    gst_caps_set_simple (src_caps, "profile", G_TYPE_STRING, "he-aac-v2", NULL);
  }

  ret = gst_audio_encoder_set_output_format (encoder, src_caps);
  if (src_caps)
    gst_caps_unref (src_caps);

  GST_DEBUG ("gst_cix_heaacv2_enc_set_format end");

  return ret;
}

static void
gst_cix_heaacv2_enc_set_property (GObject * object, guint prop_id,
    const GValue * value, GParamSpec * pspec)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_set_property");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (object);

  switch (prop_id) {
    case PROP_BITRATE:
      enc->bitrate = g_value_get_int (value);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }

  GST_DEBUG ("gst_cix_heaacv2_enc_set_property end");
}

static void
gst_cix_heaacv2_enc_get_property (GObject * object, guint prop_id,
    GValue * value, GParamSpec * pspec)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_get_property");

  GstCixHEAACV2Enc *enc = GST_CIX_HEAACV2_ENC (object);

  switch (prop_id) {
    case PROP_BITRATE:
      g_value_set_int (value, enc->bitrate);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }

  GST_DEBUG ("gst_cix_heaacv2_enc_get_property end");
}

static void
gst_cix_heaacv2_enc_init (GstCixHEAACV2Enc * enc)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_set_init");

  enc->dsp_if = NULL;
  enc->bitrate = DEFAULT_BITRATE;

  GST_DEBUG ("gst_cix_heaacv2_enc_set_init end");
}

static void
gst_cix_heaacv2_enc_class_init (GstCixHEAACV2EncClass * klass)
{
  GST_DEBUG ("gst_cix_heaacv2_enc_set_class_init");

  GObjectClass *object_class = G_OBJECT_CLASS (klass);
  GstElementClass *element_class = GST_ELEMENT_CLASS (klass);
  GstAudioEncoderClass *base_class = GST_AUDIO_ENCODER_CLASS (klass);

  object_class->set_property =
      GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_set_property);
  object_class->get_property =
      GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_get_property);

  base_class->start = GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_start);
  base_class->stop = GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_stop);
  base_class->flush = GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_flush);
  base_class->handle_frame =
      GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_handle_frame);
  base_class->set_format = GST_DEBUG_FUNCPTR (gst_cix_heaacv2_enc_set_format);

  g_object_class_install_property (object_class, PROP_BITRATE,
      g_param_spec_int ("bitrate",
          "Bitrate",
          "Target Audio Bitrate",
          DEFAULT_BITRATE_MIN, DEFUALT_BITRATE_MAX, DEFAULT_BITRATE,
          G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS));

  gst_element_class_add_static_pad_template (element_class, &sink_template);
  gst_element_class_add_static_pad_template (element_class, &src_template);

  gst_element_class_set_static_metadata (element_class,
      "cix heaacv2 encoder", "Codec/Encoder/Audio",
      "cix heaacv2 encoder", "Cix Tech.");

  GST_DEBUG_CATEGORY_INIT (gst_cix_heaacv2_enc_debug, "cixheaacv2enc", 0,
      "cix heaacv2 encoder");

  GST_DEBUG ("gst_cix_heaacv2_enc_set_class_init end");
}

GST_ELEMENT_REGISTER_DEFINE (cixheaacv2enc, "cixheaacv2enc",
    GST_RANK_MARGINAL, gst_cix_heaacv2_enc_get_type ());

static gboolean
plugin_init (GstPlugin * plugin)
{
  return GST_ELEMENT_REGISTER (cixheaacv2enc, plugin);
}

GST_PLUGIN_DEFINE (GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    cixheaacv2enc,
    "CIX HEAACV2 Encoder",
    plugin_init, VERSION, "LGPL", GST_PACKAGE_NAME, GST_PACKAGE_ORIGIN);
