class ChatEvent
  constructor: (msg) ->
    evt = document.createEvent 'Event'
    evt.initEvent 'chatEvent', true, true
    evt.message = msg.message
    evt.user = msg.user
    document.dispatchEvent evt

class Comms
  constructor: (cb) ->
    location = (window.location + 'websocket').replace /^http/, 'ws'
    @dispatcher = new WebSocketRails location
    
    # On receiving a chat trigger a chat event
    @dispatcher.bind 'chatter', (msg) ->
      new ChatEvent msg
    @dispatcher.bind 'starting_position', (data) ->
      if data.length is 2
        cb?(data)
      else
        throw new Error 'initial point back was wrong'

  sendClientChat: (msg) ->
    @dispatcher.trigger 'client_chat', msg
  moving: (direction) ->
    @dispatcher.trigger 'movement', direction

window.Comms = Comms