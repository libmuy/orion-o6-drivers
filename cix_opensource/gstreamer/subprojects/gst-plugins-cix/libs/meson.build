cix_dsp_if_sources = ['audio_dsp_if.c', 'audio_dsp_if.h']
gstcixdspif = library('gstcixdspif',
  cix_dsp_if_sources,
  c_args : gst_plugins_base_args,
  link_args : gst_plugin_ldflags,
  include_directories: [libsinc],
  dependencies : [gst_dep, gst_base_dep, gstaudio_dep, cix_dspapi_dep],
  install : true,
)

cixdspif_dep = declare_dependency(link_with : gstcixdspif)
