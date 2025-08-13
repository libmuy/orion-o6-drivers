/* GStreamer
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

/* demo application showing v4l2enc dynamic bit rate and frame rate */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gst/gst.h>
#include <gst/video/video-format.h>

#define BITRATE_CHANGE_TIME_SEC   30
#define FRAMERATE_CHANGE_TIME_SEC   60
#define FORCE_IDR_TIME_SEC   45
#define PLAY_TIME_SEC   90
#define V4L2_IO_MMAP    2


static gboolean
bus_call (GstBus * bus, GstMessage * msg, gpointer data)
{
  GMainLoop *loop = (GMainLoop *) data;

  switch (GST_MESSAGE_TYPE (msg)) {

    case GST_MESSAGE_EOS:
      g_print ("End of stream\n");
      g_main_loop_quit (loop);
      break;

    case GST_MESSAGE_ERROR:{
      gchar *debug;
      GError *error;

      gst_message_parse_error (msg, &error, &debug);
      g_free (debug);

      g_printerr ("Error: %s\n", error->message);
      g_error_free (error);

      g_main_loop_quit (loop);
      break;
    }
    default:
      break;
  }

  return TRUE;
}

static const gchar *fsrc = "/dev/zero";
static const gchar *fdst = "/dev/null";
static int width = 320;
static int height = 240;
static const gchar *encoder = "v4l2h265enc";

static GOptionEntry entries[] = {
  {"input", 'i', 0, G_OPTION_ARG_STRING, &fsrc, "Input YUV file",
      NULL},
  {"output", 'o', 0, G_OPTION_ARG_STRING, &fdst, "Output file",
      NULL},
  {"width", 'w', 0, G_OPTION_ARG_INT, &width, "Video width",
      NULL},
  {"height", 'h', 0, G_OPTION_ARG_INT, &height, "Video height",
      NULL},
  {"encoder", 'e', 0, G_OPTION_ARG_STRING, &encoder, "Encode element",
      NULL},
  {NULL}
};

static gboolean
send_bitrate (gpointer user_data)
{
  GstElement *enc = user_data;

  gst_util_set_object_arg (G_OBJECT (enc), "extra-controls",
      "encode,video_bitrate=2000000");
  g_print ("Set bit rate to 2Mbps\n");
  return FALSE;
}

static gboolean
send_framerate (gpointer user_data)
{
  GstElement *enc = user_data;

  gst_util_set_object_arg (G_OBJECT (enc), "extra-controls",
      "encode,frame_rate=196608");
  g_print ("Set frame rate to 3fps\n");
  return FALSE;
}

static gboolean
send_force_idr (gpointer user_data)
{
  GstElement *enc = user_data;

  gst_util_set_object_arg (G_OBJECT (enc), "extra-controls",
      "encode,force_key_frame=1");
  g_print ("Force key frame\n");
  return FALSE;
}

static gboolean
send_eos (gpointer user_data)
{
  GstElement *pipeline = user_data;

  gst_element_send_event (pipeline, gst_event_new_eos ());
  return FALSE;
}

int
main (int argc, char *argv[])
{
  GMainLoop *loop;

  GstElement *pipeline, *source, *filter, *parse, *enc, *sink;
  GstCaps *caps;
  GstBus *bus;
  guint bus_watch_id;
  GError *error = NULL;
  GOptionContext *context;
  gboolean ret;

  context = g_option_context_new ("- test v4l2enc dynamic");
  g_option_context_add_main_entries (context, entries, GETTEXT_PACKAGE);
  g_option_context_add_group (context, gst_init_get_option_group ());
  ret = g_option_context_parse (context, &argc, &argv, &error);
  g_option_context_free (context);

  if (!ret) {
    g_print ("option parsing failed: %s\n", error->message);
    g_error_free (error);
    return 1;
  }

  gst_init (&argc, &argv);

  loop = g_main_loop_new (NULL, FALSE);

  /* Create gstreamer elements */
  pipeline = gst_pipeline_new ("v4l2enc dynamic sample");
  source = gst_element_factory_make ("filesrc", "source");
  parse = gst_element_factory_make ("videoparse", "parse");
  filter = gst_element_factory_make ("capsfilter", "filter");
  enc = gst_element_factory_make (encoder, "enc");
  if (strncmp (encoder, "v4l2vp9enc", 10) == 0)
    sink = gst_element_factory_make ("multifilesink", "sink");
  else
    sink = gst_element_factory_make ("filesink", "sink");

  if (!pipeline || !source || !parse || !enc || !sink) {
    g_printerr ("One or more elements could not be created. Exiting.\n");
    return -1;
  }

  g_object_set (G_OBJECT (source), "location", fsrc, NULL);
  g_object_set (G_OBJECT (sink), "location", fdst, NULL);

  g_print ("Input video: %dx%d\n", width, height);
  g_object_set (G_OBJECT (parse), "width", width, NULL);
  g_object_set (G_OBJECT (parse), "height", height, NULL);
  g_object_set (G_OBJECT (parse), "format", GST_VIDEO_FORMAT_NV12, NULL);

  caps = gst_caps_from_string ("video/x-raw");
  gst_caps_set_simple (caps, "colorimetry", G_TYPE_STRING, "bt601", NULL);
  g_object_set (G_OBJECT (filter), "caps", caps, NULL);
  gst_caps_unref (caps);

  /* Set up the v4l2enc element */
  g_object_set (G_OBJECT (enc), "capture-io-mode", V4L2_IO_MMAP, NULL);
  g_object_set (G_OBJECT (enc), "output-io-mode", V4L2_IO_MMAP, NULL);
  gst_util_set_object_arg (G_OBJECT (enc), "extra-controls",
      "encode,frame_level_rate_control_enable=1,video_bitrate_mode=1,video_bitrate=600000,frame_rate=1966080");
  g_print ("Encode element: %s\n", encoder);
  g_print ("Initial bit rate 600Kbps and frame rate 30fps.\n");

  /* Add a message handler */
  bus = gst_pipeline_get_bus (GST_PIPELINE (pipeline));
  bus_watch_id = gst_bus_add_watch (bus, bus_call, loop);
  gst_object_unref (bus);

  gst_bin_add_many (GST_BIN (pipeline), source, parse, filter, enc, sink, NULL);
  gst_element_link_many (source, parse, filter, enc, sink, NULL);

  /* Set the pipeline to "playing" state */
  gst_element_set_state (pipeline, GST_STATE_PLAYING);

  /* Send new bit rate after specified time */
  g_timeout_add_seconds (BITRATE_CHANGE_TIME_SEC, send_bitrate, enc);

  /* Force IDR after sepcified time */
  g_timeout_add_seconds (FORCE_IDR_TIME_SEC, send_force_idr, enc);

  /* Send new frame rate after specified time */
  g_timeout_add_seconds (FRAMERATE_CHANGE_TIME_SEC, send_framerate, enc);

  /* Stop the playback after specified time */
  g_timeout_add_seconds (PLAY_TIME_SEC, send_eos, pipeline);

  g_main_loop_run (loop);

  /* Out of the main loop, clean up nicely */
  g_print ("Stopping playback\n");
  gst_element_set_state (pipeline, GST_STATE_NULL);

  g_print ("Deleting pipeline\n");
  gst_object_unref (GST_OBJECT (pipeline));
  g_source_remove (bus_watch_id);
  g_main_loop_unref (loop);

  return 0;
}
