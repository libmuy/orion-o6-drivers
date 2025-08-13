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

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <string.h>

#include "gstcixsr.h"
#include <gst/video/gstvideometa.h>
#include <gst/video/gstvideopool.h>

enum
{
  PROP_0,
  PROP_MODEL,
  PROP_RATIO
};

#define gst_cixsr_parent_class parent_class
G_DEFINE_TYPE (GstCixSR, gst_cixsr, GST_TYPE_VIDEO_FILTER);
GST_ELEMENT_REGISTER_DEFINE (cixsr, "cixsr", GST_RANK_NONE, GST_TYPE_CIXSR);

#define GST_CIXSR_CAPS_MAKE()                                           \
    "video/x-raw, "                                                     \
    "format = (string) RGB, "                                           \
    "width = (int) [ 1, 32767], "                                       \
    "height = (int) [ 1, 32767], "                                      \
    "framerate = (fraction) [ 0, max ]"

#define GST_CAT_DEFAULT cixsr_debug
GST_DEBUG_CATEGORY_STATIC (cixsr_debug);

static GstStaticPadTemplate gst_cixsr_src_template =
GST_STATIC_PAD_TEMPLATE ("src",
    GST_PAD_SRC,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (GST_CIXSR_CAPS_MAKE ())
    );

static GstStaticPadTemplate gst_cixsr_sink_template =
GST_STATIC_PAD_TEMPLATE ("sink",
    GST_PAD_SINK,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (GST_CIXSR_CAPS_MAKE ())
    );

static void
gst_cixsr_init (GstCixSR * sr)
{
  sr->ctx = NULL;
  sr->model_file = NULL;
  sr->frame_count = 0;
  sr->ratio = 3;
}

static GstFlowReturn
gst_cixsr_transform_frame (GstVideoFilter * filter, GstVideoFrame * in_frame,
    GstVideoFrame * out_frame)
{
  GstCixSR *sr = GST_CIXSR (filter);
  guint32 *src, *dest;
  const gchar *msg;
  noe_status_t ret = NOE_STATUS_SUCCESS;

  src = GST_VIDEO_FRAME_PLANE_DATA (in_frame, 0);
  dest = GST_VIDEO_FRAME_PLANE_DATA (out_frame, 0);

  GST_OBJECT_LOCK (sr);

  ret = noe_load_tensor (sr->ctx, sr->job_id, 0, src);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_load_tensor: %s\n", msg);
    GST_OBJECT_UNLOCK (sr);
    return GST_FLOW_ERROR;
  }

  ret = noe_job_infer_sync (sr->ctx, sr->job_id, 3000);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_job_infer_sync: %s\n", msg);
    GST_OBJECT_UNLOCK (sr);
    return GST_FLOW_ERROR;
  }

  ret = noe_get_tensor (sr->ctx, sr->job_id, NOE_TENSOR_TYPE_OUTPUT, 0, dest);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_get_tensor: %s\n", msg);
    GST_OBJECT_UNLOCK (sr);
    return GST_FLOW_ERROR;
  }

  GST_OBJECT_UNLOCK (sr);

  return GST_FLOW_OK;
}

static gboolean
gst_cixsr_start (GstBaseTransform * trans)
{
  GstCixSR *sr = GST_CIXSR (trans);
  const gchar *msg;
  job_config_npu_t npu_config = { 0 };
  job_config_t create_job_cfg = { 0 };
  create_job_cfg.conf_j_npu = &npu_config;

  noe_status_t ret = NOE_STATUS_SUCCESS;

  ret = noe_init_context (&sr->ctx);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_init_context: %s\n", msg);
    return FALSE;
  }

  GST_DEBUG_OBJECT (sr, "Load model file: %s\n", sr->model_file);
  ret = noe_load_graph (sr->ctx, sr->model_file, &sr->graph_id, NULL);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_load_graph: %s (%s)\n", msg, sr->model_file);
    noe_deinit_context (sr->ctx);
    return FALSE;
  }

  ret = noe_get_tensor_count (sr->ctx, sr->graph_id,
      NOE_TENSOR_TYPE_INPUT, &sr->input_cnt);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_get_tensor_count: %s\n", msg);
    noe_unload_graph (sr->ctx, sr->graph_id);
    noe_deinit_context (sr->ctx);
    return FALSE;
  }

  for (uint32_t i = 0; i < sr->input_cnt; i++) {
    tensor_desc_t desc;
    ret = noe_get_tensor_descriptor (sr->ctx, sr->graph_id,
        NOE_TENSOR_TYPE_INPUT, i, &desc);
    if (ret != NOE_STATUS_SUCCESS) {
      noe_get_error_message (sr->ctx, ret, &msg);
      GST_ERROR_OBJECT (sr, "noe_get_tensor_descriptor: %s\n", msg);
      noe_unload_graph (sr->ctx, sr->graph_id);
      noe_deinit_context (sr->ctx);
      return FALSE;
    }
    GST_DEBUG_OBJECT (trans,
        "Input %d desc: id=%d, size=%d, scale=%f, zero_point=%f, data_type=%d",
        i, desc.id, desc.size, desc.scale, desc.zero_point, desc.data_type);
  }

  ret = noe_get_tensor_count (sr->ctx, sr->graph_id,
      NOE_TENSOR_TYPE_OUTPUT, &sr->output_cnt);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_get_tensor_count: %s\n", msg);
    noe_unload_graph (sr->ctx, sr->graph_id);
    noe_deinit_context (sr->ctx);
    return FALSE;
  }

  for (uint32_t i = 0; i < sr->output_cnt; i++) {
    tensor_desc_t desc;
    ret = noe_get_tensor_descriptor (sr->ctx, sr->graph_id,
        NOE_TENSOR_TYPE_OUTPUT, i, &desc);
    if (ret != NOE_STATUS_SUCCESS) {
      noe_get_error_message (sr->ctx, ret, &msg);
      GST_ERROR_OBJECT (sr, "noe_get_tensor_descriptor: %s\n", msg);
      noe_unload_graph (sr->ctx, sr->graph_id);
      noe_deinit_context (sr->ctx);
      return FALSE;
    }
    GST_DEBUG_OBJECT (trans,
        "Output %d desc: id=%d, size=%d, scale=%f, zero_point=%f, data_type=%d",
        i, desc.id, desc.size, desc.scale, desc.zero_point, desc.data_type);
  }

  ret = noe_create_job (sr->ctx, sr->graph_id, &sr->job_id, &create_job_cfg);
  if (ret != NOE_STATUS_SUCCESS) {
    noe_get_error_message (sr->ctx, ret, &msg);
    GST_ERROR_OBJECT (sr, "noe_create_job: %s\n", msg);
    noe_unload_graph (sr->ctx, sr->graph_id);
    noe_deinit_context (sr->ctx);
    return FALSE;
  }

  return TRUE;
}

static void
gst_cixsr_finalize (GObject * object)
{
  GstCixSR *sr = GST_CIXSR (object);

  noe_clean_job (sr->ctx, sr->job_id);
  noe_unload_graph (sr->ctx, sr->graph_id);
  noe_deinit_context (sr->ctx);
  g_free (sr->model_file);

  G_OBJECT_CLASS (parent_class)->finalize (object);
}

static void
gst_cixsr_set_property (GObject * object, guint prop_id,
    const GValue * value, GParamSpec * pspec)
{
  GstCixSR *sr;

  g_return_if_fail (GST_CIXSR (object));

  sr = GST_CIXSR (object);

  switch (prop_id) {
    case PROP_MODEL:
      sr->model_file = g_strdup (g_value_get_string (value));
      break;
    case PROP_RATIO:
      sr->ratio = g_value_get_uint (value);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }
}

static void
gst_cixsr_get_property (GObject * object, guint prop_id, GValue * value,
    GParamSpec * pspec)
{
  GstCixSR *sr;

  g_return_if_fail (GST_CIXSR (object));

  sr = GST_CIXSR (object);

  switch (prop_id) {
    case PROP_MODEL:
      g_value_set_string (value, sr->model_file);
      break;
    case PROP_RATIO:
      g_value_set_uint (value, sr->ratio);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }
}

static GstCaps *
gst_cixsr_caps_remove_format_and_rangify_size_info (GstCixSR * self,
    GstPadDirection direction, GstCaps * caps)
{
  GstCaps *ret;
  GstStructure *structure;
  GstCapsFeatures *features;
  const GValue *v;
  gint i, n;
  gint w = 0, h = 0;

  ret = gst_caps_new_empty ();

  n = gst_caps_get_size (caps);
  for (i = 0; i < n; i++) {
    structure = gst_caps_get_structure (caps, i);
    features = gst_caps_get_features (caps, i);

    /* If this is already expressed by the existing caps
     * skip this structure */
    if (i > 0 && gst_caps_is_subset_structure_full (ret, structure, features))
      continue;

    structure = gst_structure_copy (structure);
    if (!gst_caps_features_is_any (features)) {
      v = gst_structure_get_value (structure, "width");
      if (G_VALUE_HOLDS_INT (v)) {
        if (direction == GST_PAD_SRC)
          w = g_value_get_int (v) / self->ratio;
        else
          w = g_value_get_int (v) * self->ratio;
      }

      v = gst_structure_get_value (structure, "height");
      if (G_VALUE_HOLDS_INT (v)) {
        if (direction == GST_PAD_SRC)
          h = g_value_get_int (v) / self->ratio;
        else
          h = g_value_get_int (v) * self->ratio;
      }

      if (w > 0 && h > 0)
        gst_structure_set (structure, "width", G_TYPE_INT, w,
            "height", G_TYPE_INT, h, NULL);
    }
    gst_caps_append_structure_full (ret, structure,
        gst_caps_features_copy (features));
  }

  return ret;
}

static GstCaps *
gst_cixsr_transform_caps (GstBaseTransform * trans,
    GstPadDirection direction, GstCaps * caps, GstCaps * filter)
{
  GstCixSR *sr = GST_CIXSR (trans);
  GstCaps *ret;

  GST_DEBUG_OBJECT (trans,
      "Transforming caps %" GST_PTR_FORMAT " in direction %s", caps,
      (direction == GST_PAD_SINK) ? "sink" : "src");

  ret =
      gst_cixsr_caps_remove_format_and_rangify_size_info (sr, direction, caps);
  if (filter) {
    GstCaps *intersection;

    intersection =
        gst_caps_intersect_full (filter, ret, GST_CAPS_INTERSECT_FIRST);
    gst_caps_unref (ret);
    ret = intersection;
  }

  GST_DEBUG_OBJECT (trans, "returning caps: %" GST_PTR_FORMAT, ret);

  return ret;
}

static void
gst_cixsr_class_init (GstCixSRClass * klass)
{
  GObjectClass *gobject_class = (GObjectClass *) klass;
  GstElementClass *gstelement_class = (GstElementClass *) klass;
  GstBaseTransformClass *trans_class = (GstBaseTransformClass *) klass;
  GstVideoFilterClass *vfilter_class = (GstVideoFilterClass *) klass;

  GST_DEBUG_CATEGORY_INIT (cixsr_debug, "cixsr", 0, "cixsr element");

  gobject_class->set_property = gst_cixsr_set_property;
  gobject_class->get_property = gst_cixsr_get_property;

  g_object_class_install_property (gobject_class, PROP_MODEL,
      g_param_spec_string ("model", "Model Location",
          "Location of the super resolution model file to load", NULL,
          G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS |
          GST_PARAM_MUTABLE_READY));

  g_object_class_install_property (gobject_class, PROP_RATIO,
      g_param_spec_uint ("ratio", "Up-scaling ratio",
          "Up-scaling ratio if super resolution", 2, 4, 3, G_PARAM_READWRITE));

  gobject_class->finalize = gst_cixsr_finalize;

  gst_element_class_set_static_metadata (gstelement_class,
      "CIX Super Resolution", "Filter/Converter/Video/Scaler",
      "Apply super resolution on video frames",
      "Zhan Lou <zhan.lou@cixtech.com>");

  gst_element_class_add_static_pad_template (gstelement_class,
      &gst_cixsr_sink_template);
  gst_element_class_add_static_pad_template (gstelement_class,
      &gst_cixsr_src_template);

  trans_class->start = GST_DEBUG_FUNCPTR (gst_cixsr_start);

  trans_class->transform_caps = GST_DEBUG_FUNCPTR (gst_cixsr_transform_caps);

  vfilter_class->transform_frame =
      GST_DEBUG_FUNCPTR (gst_cixsr_transform_frame);
}

/* entry point to initialize the plug-in */
static gboolean
cixsr_init (GstPlugin * plugin)
{
  return GST_ELEMENT_REGISTER (cixsr, plugin);
}

/* gstreamer looks for this structure to register plugins */
GST_PLUGIN_DEFINE (GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    cixsr,
    "CIX Super Resolution",
    cixsr_init, VERSION, "LGPL", GST_PACKAGE_NAME, GST_PACKAGE_ORIGIN)
