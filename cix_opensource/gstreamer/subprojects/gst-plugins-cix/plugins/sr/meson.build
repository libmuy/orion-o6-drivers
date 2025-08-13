cixsr_sources = [
  'gstcixsr.c',
]

noe_dep = dependency('cix-noe-umd')

gstcixsr = library('gstcixsr',
  cixsr_sources,
  c_args : gst_plugins_base_args,
  include_directories : [configinc],
  dependencies : [gst_dep, gst_base_dep, gstvideo_dep, noe_dep],
  install : true,
  install_dir : plugins_install_dir,
)
plugins += [gstcixsr]
