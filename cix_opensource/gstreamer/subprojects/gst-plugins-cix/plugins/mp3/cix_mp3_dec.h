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

#ifndef __CIX_MP3_DECODER__
#define __CIX_MP3_DECODER__
#include <gst/gst.h>

#include "cix_dsp_api.h"
#include "audio_dsp_if.h"

G_BEGIN_DECLS
#define GST_TYPE_CIX_MP3_DEC (gst_cix_mp3_dec_get_type())
G_DECLARE_FINAL_TYPE (GstCixMP3Dec, gst_cix_mp3_dec,
    GST, CIX_MP3_DEC, GstAudioDecoder)
     struct _GstCixMP3Dec
     {
       GstAudioDecoder parent;
       GstAudioInfo audioinfo;

       /* dsp APIs */
       struct cix_dsp_if *dsp_if;

     };

GST_ELEMENT_REGISTER_DECLARE (cixmp3dec);

G_END_DECLS
#endif /* __CIX_MP3_DECODER__ */
