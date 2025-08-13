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

#ifndef __CIX_HEAACV2_ENCODER__
#define __CIX_HEAACV2_ENCODER__

#include <gst/gst.h>

#include "audio_dsp_if.h"

G_BEGIN_DECLS

enum
{
  PROP_BITRATE = 1,
};

#define DEFAULT_BITRATE 56000
#define DEFAULT_BITRATE_MIN 8000
#define DEFUALT_BITRATE_MAX 800000

G_DECLARE_FINAL_TYPE (GstCixHEAACV2Enc, gst_cix_heaacv2_enc,
    GST, CIX_HEAACV2_ENC, GstAudioEncoder)
     struct _GstCixHEAACV2Enc
     {
       GstAudioEncoder element;

       /* dsp APIs */
       struct cix_dsp_if *dsp_if;

       gint bitrate;
     };

GST_ELEMENT_REGISTER_DECLARE (cixheaacv2enc);

G_END_DECLS

#endif /* __CIX_HEAACV2_ENCODER__ */
