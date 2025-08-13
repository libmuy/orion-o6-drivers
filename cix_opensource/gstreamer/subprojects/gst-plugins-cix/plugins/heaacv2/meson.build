cix_heaacv2_enc_sources = ['cix_heaacv2_enc.c', 'cix_heaacv2_enc.h']
cixheaacv2enc = library('gstcixheaacv2enc',
  cix_heaacv2_enc_sources,
  c_args : gst_plugins_base_args,
  link_args : gst_plugin_ldflags,
  include_directories: [libsinc],
  dependencies : [gst_dep, gst_base_dep, gstaudio_dep, cixdspif_dep],
  install : true,
  install_dir : plugins_install_dir,
)
plugins += [cixheaacv2enc]
