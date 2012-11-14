class WebSocketController < WebsocketRails::BaseController
  # initializer for this class
  def initialize_session  
  end
  # testing with:
  # var dispatcher = new WebSocketRails('localhost:3000/websocket');
  # dispatcher.trigger('client_message', 'hello world');
  #
  # message can be of types:
  # Fixnum (5, 5.0)
  # Float (5.2)
  # String ('dog')
  # NilClass (NaN, null, undefined)
  # FalseClass (false) or TrueClass (true)
  # Array
  # ActiveSupport::HashWithIndifferentAccess
  
  # When the client connects:
  # give them their initial coordinates, player list
  # then broadcast that they connected
  def client_connected
    puts "client #{current_user.email} connected"
    current_player = current_user.player || current_user.create_player
    current_player.is_online = true
    current_player.save
    coords = [
      current_player.left,
      current_player.top,
      current_player.id,
      current_player.last_direction
    ]
    send_message :starting_position, coords
    
    # Get an array of the other players, convert to hash keyed on player id
    players = Player.where 'user_id != ? and is_online = ?', current_user, true
    player_hash = {}
    players.each do |player|
      player_hash[player.id] = {
        user_name:      player.user.email.sub(/@.+/, ''),
        is_moving:      player.is_moving,
        last_direction: player.last_direction,
        left:           player.left,
        top:            player.top
      }
    end
    send_message :player_list, player_hash
    
    broadcast_message :player_enter, {
      user_name:      current_user.email.sub(/@.+/, ''),
      id:             current_player.id,
      last_direction: current_player.last_direction,
      left:           current_player.left,
      top:            current_player.top
    }
  end
  # The built in client_disconnected event is buggy as hell for page refreshes
  # https://github.com/DanKnox/websocket-rails/issues/24
  # But I fixed it and contributed the patch upstream! Cool!
  # https://github.com/DanKnox/websocket-rails/pull/25
  def client_disconnected
    puts "client #{current_user.email} disconnected"
    current_player = current_user.player
    broadcast_message :player_exit, {
      id:   current_player.id
    }
    current_player.is_online = false
    current_player.save
  end
  def client_chat
    puts "Received message #{message} of type #{message.class} from user " +
      current_user.email
    if message.class == String
      broadcast_message :chatter, {
        message: message,
        user: current_user.email.sub(/@.+/, '')
      }
    end
  end
  def movement_start
    return unless message['left'] && message['top'] && message['direction'] &&
      message['direction'] == 'up'   || message['direction'] == 'down'      ||
      message['direction'] == 'left' || message['direction'] == 'right'
    puts "#{current_user.email} started moving #{message['direction']}"
    player = Player.find_by_user_id current_user
    player.left           = message['left']
    player.top            = message['top']
    player.last_direction = message['direction']
    player.is_moving      = true
    player.save
    broadcast_message :movement, {
      id:             player.id,
      last_direction: player.last_direction
    }
  end
  def movement_end
    puts "#{current_user.email} stopped moving: #{message}"
    return unless message['left'] && message['top']
    player = Player.find_by_user_id current_user
    player.update_attributes({
      left:           message['left'],
      top:            message['top'],
      is_moving:      false
    })
    broadcast_message :stoppage, {id: player.id}
  end
end
