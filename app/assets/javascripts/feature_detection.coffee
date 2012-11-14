# Audio
audio_supported = ->
  !!document.createElement('audio').canPlayType

mp3_supported = ->
  a = document.createElement 'audio'
  !!(a.canPlayType and a.canPlayType 'audio/mpeg').replace /no/, ''

vorbis_supported = ->
  a = document.createElement 'audio'
  !!(a.canPlayType and a.canPlayType 'audio/ogg').replace /no/, ''

# Canvas
canvas_supported = ->
  !!document.createElement('canvas').getContext

canvas_text_supported = ->
  c = document.createElement 'canvas'
  c.getContext and typeof c.getContext('2d').fillText is 'function'

# Websockets
websockets_supported = ->
  !!window.WebSocket

unless audio_supported() and (mp3_supported() or vorbis_supported()) and
canvas_supported() and websockets_supported()
  alert 'Your browser does not support one or more of the following new html5 ' +
  'features required to play this game: \n\nAudio\nCanvas\nWebSockets\n\n'    +
  'You will now be redirected to browsehappy.com, a site that can recommend ' +
  'a more modern browser for you.'
  window.location = 'http://browsehappy.com/'
  