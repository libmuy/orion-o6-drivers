plugins = []
libraries = []

subdir('mp3')
subdir('heaacv2')
subdir('afbcparse')
subdir('sr')

plugin_names = []
foreach plugin: plugins
  if plugin.name().startswith('gst')
    plugin_names += [plugin.name().substring(3)]
  else
    plugin_names += [plugin.name()]
  endif
endforeach

summary({
    'Plugins': plugin_names,
}, list_sep: ', ')
