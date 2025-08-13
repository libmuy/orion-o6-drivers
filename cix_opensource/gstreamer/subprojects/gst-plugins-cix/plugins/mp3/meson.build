cix_mp3_dec_sources = ['cix_mp3_dec.c', 'cix_mp3_dec.h']
cixmp3dec = library('gstcixmp3dec',
  cix_mp3_dec_sources,
  c_args : gst_plugins_base_args,
  link_args : gst_plugin_ldflags,
  include_directories: [libsinc],
  dependencies : [gst_dep, gst_base_dep, gstaudio_dep, cixdspif_dep],
  install : true,
  install_dir : plugins_install_dir,
)
plugins += [cixmp3dec]
