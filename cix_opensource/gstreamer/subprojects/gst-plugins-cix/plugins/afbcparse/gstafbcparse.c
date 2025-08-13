/* GStreamer AFBC parser
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

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#include "gstafbcparse.h"

#define AFBC_FRAME_HEADER_SIZE (sizeof (GstAfbcFrameHeader))
#define AFBC_MIN_MB_SIZE 384
#define AFBC_MIN_FRAME_SIZE (AFBC_FRAME_HEADER_SIZE + AFBC_MIN_MB_SIZE)

#define GST_AFBC_CAPS_MAKE(format)                                      \
    "video/x-raw, "                                                     \
    "format = (string) " format ", "                                    \
    "width = (int) [ 1, 32767], "                                       \
    "height = (int) [ 1, 32767], "                                      \
    "framerate = (fraction) [ 0, max ]"

GST_DEBUG_CATEGORY_STATIC (gst_afbc_parse_debug);
#define GST_CAT_DEFAULT gst_afbc_parse_debug

/* sink and src pad templates */
static GstStaticPadTemplate sink_factory = GST_STATIC_PAD_TEMPLATE ("sink",
    GST_PAD_SINK,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS ("video/x-afbc")
    );

static GstStaticPadTemplate src_factory = GST_STATIC_PAD_TEMPLATE ("src",
    GST_PAD_SRC,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (GST_AFBC_CAPS_MAKE
        ("{YUV420_AFBC_8, YUV420_AFBC_10, YUV422_AFBC_8, YUV422_AFBC_10}"))
    );

#define gst_afbc_parse_parent_class parent_class
G_DEFINE_TYPE (GstAfbcParse, gst_afbc_parse, GST_TYPE_BASE_PARSE);
GST_ELEMENT_REGISTER_DEFINE (afbcparse, "afbcparse", GST_RANK_PRIMARY,
    GST_TYPE_AFBC_PARSE);

static gboolean gst_afbc_parse_start (GstBaseParse * parse);

static GstFlowReturn
gst_afbc_parse_handle_frame (GstBaseParse * parse,
    GstBaseParseFrame * frame, gint * skipsize);

/* initialize the afbcparse's class */
static void
gst_afbc_parse_class_init (GstAfbcParseClass * klass)
{
  GstElementClass *gstelement_class;
  GstBaseParseClass *gstbaseparse_class;

  gstelement_class = (GstElementClass *) klass;
  gstbaseparse_class = (GstBaseParseClass *) klass;

  gstbaseparse_class->start = gst_afbc_parse_start;
  gstbaseparse_class->handle_frame = gst_afbc_parse_handle_frame;

  gst_element_class_add_static_pad_template (gstelement_class, &src_factory);
  gst_element_class_add_static_pad_template (gstelement_class, &sink_factory);

  gst_element_class_set_static_metadata (gstelement_class,
      "AFBC parser", "Codec/Demuxer",
      "Demuxes a AFBC file", "Zhan Lou <zhan.lou@cixtech.com>");

  /* debug category for filtering log messages */
  GST_DEBUG_CATEGORY_INIT (gst_afbc_parse_debug, "afbcparse", 0, "AFBC parser");
}

/* initialize the new element
 * instantiate pads and add them to element
 * set pad callback functions
 * initialize instance structure
 */
static void
gst_afbc_parse_init (GstAfbcParse * afbc)
{
  afbc->update_caps = FALSE;
}

static gboolean
gst_afbc_parse_start (GstBaseParse * parse)
{
  GstAfbcParse *const afbc = GST_AFBC_PARSE (parse);

  afbc->update_caps = TRUE;
  afbc->fps_n = 60;
  afbc->fps_d = 1;

  gst_base_parse_set_min_frame_size (parse, AFBC_MIN_FRAME_SIZE);

  /* No sync code to detect frame boundaries */
  gst_base_parse_set_syncable (parse, FALSE);

  return TRUE;
}

static void
gst_afbc_parse_update_src_caps (GstAfbcParse * afbc)
{
  const gchar *format = NULL;
  GstAfbcFrameHeader *header = &afbc->frame_header;
  GstCaps *caps, *peercaps;
  if (!afbc->update_caps &&
      G_LIKELY (gst_pad_has_current_caps (GST_BASE_PARSE_SRC_PAD (afbc))))
    return;
  afbc->update_caps = FALSE;

  /* Create src pad caps */
  caps = gst_caps_new_empty_simple ("video/x-raw");
  if (header->width > 0 && header->height > 0) {
    gst_caps_set_simple (caps, "width", G_TYPE_INT, header->width,
        "height", G_TYPE_INT, header->height, NULL);
  }

  gst_base_parse_set_frame_rate (GST_BASE_PARSE_CAST (afbc),
      afbc->fps_n, afbc->fps_d, 0, 0);
  gst_caps_set_simple (caps, "framerate", GST_TYPE_FRACTION, afbc->fps_n,
      afbc->fps_d, NULL);

  if (header->subsampling == 1) {
    if (header->y_bits == 8)
      format = "YUV420_AFBC_8";
    else if (header->y_bits == 10)
      format = "YUV420_AFBC_10";
  } else if (header->subsampling == 2) {
    if (header->y_bits == 8)
      format = "YUV422_AFBC_8";
    else if (header->y_bits == 10)
      format = "YUV422_AFBC_10";
  }

  if (format != NULL)
    gst_caps_set_simple (caps, "format", G_TYPE_STRING, format, NULL);

  GST_LOG_OBJECT (afbc, "Set src pad caps: %" GST_PTR_FORMAT, caps);
  gst_pad_set_caps (GST_BASE_PARSE_SRC_PAD (afbc), caps);

  peercaps = gst_pad_peer_query_caps (GST_BASE_PARSE_SRC_PAD (afbc), caps);
  gst_caps_unref (caps);
  if (!peercaps || gst_caps_is_empty (peercaps) || gst_caps_is_any (peercaps))
    return;
  if (peercaps) {
    peercaps = gst_caps_fixate (peercaps);
    gst_pad_set_caps (GST_BASE_PARSE_SRC_PAD (afbc), peercaps);
    GST_LOG_OBJECT (afbc, "Negotiated caps %" GST_PTR_FORMAT, peercaps);
    gst_caps_unref (peercaps);
  }
}

static GstFlowReturn
gst_afbc_parse_handle_frame (GstBaseParse * parse,
    GstBaseParseFrame * frame, gint * skipsize)
{
  GstAfbcParse *const afbc = GST_AFBC_PARSE (parse);
  GstBuffer *const buffer = frame->buffer;
  GstMapInfo map;
  GstFlowReturn ret = GST_FLOW_OK;
  GstBuffer *out_buffer;

  gst_buffer_map (buffer, &map, GST_MAP_READ);
  if (map.size >= AFBC_FRAME_HEADER_SIZE) {
    guint64 frame_pts = afbc->frame_count;
    GstAfbcFrameHeader *header = &afbc->frame_header;
    memcpy (header, map.data, AFBC_FRAME_HEADER_SIZE);

    GST_LOG_OBJECT (afbc,
        "Read frame header: size %u, pts %" G_GUINT64_FORMAT,
        header->frame_size, frame_pts);

    if (map.size < header->header_size + header->frame_size) {
      gst_base_parse_set_min_frame_size (GST_BASE_PARSE_CAST (afbc),
          header->header_size + header->frame_size);
      gst_buffer_unmap (buffer, &map);
      *skipsize = 0;
      goto end;
    }

    gst_buffer_unmap (buffer, &map);

    /* Eventually, we would need the buffer memory in a merged state anyway */
    out_buffer = gst_buffer_copy_region (buffer, GST_BUFFER_COPY_FLAGS |
        GST_BUFFER_COPY_TIMESTAMPS | GST_BUFFER_COPY_META |
        GST_BUFFER_COPY_MEMORY | GST_BUFFER_COPY_MERGE,
        header->header_size, header->frame_size);
    if (!out_buffer) {
      GST_ERROR_OBJECT (afbc, "Failed to copy frame buffer");
      ret = GST_FLOW_ERROR;
      *skipsize = header->header_size + header->frame_size;
      goto end;
    }
    gst_buffer_replace (&frame->out_buffer, out_buffer);
    gst_buffer_unref (out_buffer);

    if (afbc->fps_n > 0) {
      GST_BUFFER_TIMESTAMP (out_buffer) =
          gst_util_uint64_scale_int (GST_SECOND * frame_pts, afbc->fps_d,
          afbc->fps_n);
    }

    gst_afbc_parse_update_src_caps (afbc);

    ret = gst_base_parse_finish_frame (GST_BASE_PARSE_CAST (afbc), frame,
        header->header_size + header->frame_size);
    *skipsize = 0;
    afbc->frame_count++;
  } else {
    GST_LOG_OBJECT (afbc, "Frame data not yet available.");
    gst_buffer_unmap (buffer, &map);
    *skipsize = 0;
  }

end:
  return ret;
}

/* entry point to initialize the plug-in */
static gboolean
afbcparse_init (GstPlugin * plugin)
{
  return GST_ELEMENT_REGISTER (afbcparse, plugin);
}

/* gstreamer looks for this structure to register plugins */
GST_PLUGIN_DEFINE (GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    afbcparse,
    "AFBC parser",
    afbcparse_init, VERSION, "LGPL", GST_PACKAGE_NAME, GST_PACKAGE_ORIGIN)
