afbcparse_sources = [
  'gstafbcparse.c',
]

gstafbcparse = library('gstafbcparse',
  afbcparse_sources,
  c_args : gst_plugins_base_args,
  dependencies : [gst_base_dep],
  install : true,
  install_dir : plugins_install_dir,
)
plugins += [gstafbcparse]
