project('gst-plugins-cix', 'c',
  version : '1.22.1',
  meson_version : '>= 0.59',
)

api_version = '1.0'

gst_req = '>= 1.22.1'

pro_version = meson.project_version()
pro_name = meson.project_name()

plugins_install_dir = join_paths(get_option('libdir'), 'gstreamer-1.0')

cc = meson.get_compiler('c')

unneeded_dep = dependency('', required : false)
if unneeded_dep.found()
  error ('Found unfindable dependency')
endif

#below two marcos are defined in autoconf
add_project_arguments ('-DARM', language: 'c')
add_project_arguments ('-D_GUNC_', language: 'c')

gst_dep = dependency('gstreamer-' + api_version, version : gst_req)
gst_base_dep = dependency('gstreamer-base-' + api_version, version : gst_req)
gstaudio_dep = dependency('gstreamer-audio-1.0', version : gst_req, fallback : ['gst-plugins-base', 'audio_dep'])
gstvideo_dep = dependency('gstreamer-video-1.0', version : gst_req, fallback : ['gst-plugins-base', 'video_dep'])
gst_allocator_dep = dependency('gstreamer-allocators-' + api_version, version : gst_req)
gst_plugins_base_dep = dependency('gstreamer-base-' + api_version, version : gst_req)
cix_dspapi_dep = cc.find_library('dsp_wrap', required: false)

gst_plugin_ldflags=['-ldl']
gst_plugins_base_args = ['-DHAVE_CONFIG_H']

libsinc = include_directories('libs')
configinc = include_directories('.')

subdir('libs')
subdir('plugins')
subdir('tests')
