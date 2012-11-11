class ChatEvent
  constructor: (msg) ->
    evt = document.createEvent 'Event'
    evt.initEvent 'chatEvent', true, true
    evt.message = msg.message
    evt.user = msg.user
    document.dispatchEvent evt

class Comms
  constructor: (current_player) ->
    location = (window.location + 'websocket').replace /^http/, 'ws'
    @dispatcher = new WebSocketRails location
    
    # On receiving a chat trigger a chat event
    @dispatcher.bind 'chatter', (msg) ->
      new ChatEvent msg

  sendClientChat: (msg) ->
    @dispatcher.trigger 'client_chat', msg

window.Comms = Comms