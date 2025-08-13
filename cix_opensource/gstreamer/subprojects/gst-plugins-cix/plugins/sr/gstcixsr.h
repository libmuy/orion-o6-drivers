/* GStreamer super resolution
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

#ifndef __GST_CIXSR_H__
#define __GST_CIXSR_H__

#include <gst/gst.h>

#include <gst/video/video.h>
#include <gst/video/gstvideofilter.h>

#include "npu/cix_noe_standard_api.h"

G_BEGIN_DECLS

#define GST_TYPE_CIXSR \
  (gst_cixsr_get_type())
#define GST_CIXSR(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj),GST_TYPE_CIXSR,GstCixSR))
#define GST_CIXSR_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_CAST((klass),GST_TYPE_CIXSR,GstCixSRClass))
#define GST_IS_CIXSR(obj) \
  (G_TYPE_CHECK_INSTANCE_TYPE((obj),GST_TYPE_CIXSR))
#define GST_IS_CIXSR_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_TYPE((klass),GST_TYPE_CIXSR))

typedef struct _GstCixSR GstCixSR;
typedef struct _GstCixSRClass GstCixSRClass;

struct _GstCixSR
{
  GstVideoFilter videofilter;

  /* < private > */
  context_handler_t* ctx;
  guint64 graph_id;
  guint64 job_id;
  gchar *model_file;
  guint ratio;
  gint32 frame_count;
  guint32 input_cnt;
  guint32 output_cnt;
};

struct _GstCixSRClass
{
  GstVideoFilterClass parent_class;
};

GType gst_cixsr_get_type (void);

G_END_DECLS

#endif /* __GST_CIXSR_H__ */
