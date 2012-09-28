class ChatEvent
  constructor: (msg) ->
    evt = document.createEvent 'Event'
    evt.initEvent 'chatEvent', true, true
    evt.msg = msg
    document.dispatchEvent evt

$(document).ready ->
  chat_box = document.getElementById 'chat_box'
  chat_bar = document.getElementById 'chat_bar'
  return unless chat_box && chat_bar

  chat_bar.addEventListener 'keyup', (e) ->
    # if user presses enter
    if e.keyCode is 13
      new ChatEvent chat_bar.value
  
  document.addEventListener 'chatEvent', (e) ->
    alert 'chat event: ' + e.msg