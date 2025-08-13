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

#ifndef __GST_AFBC_PARSE_H__
#define __GST_AFBC_PARSE_H__

#include <gst/gst.h>
#include <gst/base/gstbaseparse.h>

G_BEGIN_DECLS

#define GST_TYPE_AFBC_PARSE \
  (gst_afbc_parse_get_type())
#define GST_AFBC_PARSE(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj),GST_TYPE_AFBC_PARSE,GstAfbcParse))
#define GST_AFBC_PARSE_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_CAST((klass),GST_TYPE_AFBC_PARSE,GstAfbcParseClass))
#define GST_IS_AFBC_PARSE(obj) \
  (G_TYPE_CHECK_INSTANCE_TYPE((obj),GST_TYPE_AFBC_PARSE))
#define GST_IS_AFBC_PARSE_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_TYPE((klass),GST_TYPE_AFBC_PARSE))

typedef struct _GstAfbcParse GstAfbcParse;
typedef struct _GstAfbcParseClass GstAfbcParseClass;
typedef struct _GstAfbcFrameHeader GstAfbcFrameHeader;

struct _GstAfbcFrameHeader
{
    guint32 magic;
    guint16 header_size;
    guint16 version;
    guint32 frame_size;
    guint8 num_components;
    guint8 subsampling;
    guint8 yuv_transform;
    guint8 block_split;
    guint8 y_bits;
    guint8 cb_bits;
    guint8 cr_bits;
    guint8 alpha_bits;
    guint16 mb_width;
    guint16 mb_height;
    guint16 width;
    guint16 height;
    guint8 crop_left;
    guint8 crop_top;
    guint8 param;
    guint8 file_message;
};

struct _GstAfbcParse
{
  GstBaseParse baseparse;

  GstAfbcFrameHeader frame_header;

  gboolean update_caps;
  guint frame_count;
  guint width;
  guint height;
  guint fps_n;
  guint fps_d;
};

struct _GstAfbcParseClass
{
  GstBaseParseClass parent_class;
};

GType gst_afbc_parse_get_type (void);
GST_ELEMENT_REGISTER_DECLARE (afbcparse);

G_END_DECLS

#endif /* __GST_AFBC_PARSE_H__ */
