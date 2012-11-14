class ChatEvent
  constructor: (msg) ->
    evt = document.createEvent 'Event'
    evt.initEvent 'chatEvent', true, true
    evt.message = msg.message
    evt.user = msg.user
    document.dispatchEvent evt

class Comms
  constructor: (player_list, cb) ->
    location = (window.location + 'websocket').replace /^http/, 'ws'
    @dispatcher = new WebSocketRails location
    @currentPlayerID = 0;
    
    # On receiving a chat trigger a chat event
    @dispatcher.bind 'chatter', (msg) ->
      new ChatEvent msg
    @dispatcher.bind 'starting_position', (data) =>
      if data.length is 4
        @currentPlayerID = data[2]
        cb?(data)
      else
        throw new Error 'initial point back was wrong'
    @dispatcher.bind 'player_list', (data) ->
      load_player = (id, player, player_list) ->
        p = new Player id, player.left, player.top
        p.load 'assets/lock.png', ->
          p[player.last_direction]()
          p.stop()
          player_list[id] = p
      for id, player of data
        load_player id, player, player_list
      null
    @dispatcher.bind 'movement', (data) =>
      return if data.id is @currentPlayerID
      player_list[data.id][data.last_direction]()
    @dispatcher.bind 'stoppage', (data) =>
      return if data.id is @currentPlayerID
      player_list[data.id].stop()

  sendClientChat: (msg) ->
    @dispatcher.trigger 'client_chat', msg
  moving: (player, direction) ->
    @dispatcher.trigger 'movement_start',
      left: player.sprite.left,
      top: player.sprite.top,
      direction: direction
  stopped: (player) ->
    @dispatcher.trigger 'movement_end',
      left: player.sprite.left,
      top: player.sprite.top

window.Comms = Comms
