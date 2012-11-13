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
  
  # When the client connects, give them their initial coordinates and player map
  def client_connected
    puts "client #{current_user.email} connected"
    current_player = current_user.player || current_user.create_player
    coords = [current_player.left, current_player.top]
    puts "sending coordinates #{coords}"
    send_message :starting_position, coords
    
    # Get an array of the other players, convert to hash keyed on user id
    players = Player.where 'user_id != ?', current_user
    player_hash = {}
    players.each do |player|
      player_hash[player.user_id] = {
        is_moving:      player.is_moving,
        last_direction: player.last_direction,
        left:           player.left,
        top:            player.top
      }
    end
    send_message :player_list, player_hash
  end
  # The built in client_disconnected event is buggy as hell for page refreshes
  # https://github.com/DanKnox/websocket-rails/issues/24
  def client_disconnected
    puts "client #{current_user.email} disconnected"
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
    puts "#{current_user.email} started moving: #{message}"
    return unless message['left'] && message['top'] && message['direction']
    Player.find_by_user_id(current_user).update_attributes({
      left:           message['left'],
      top:            message['top'],
      last_direction: message['direction'],
      is_moving:      true
    })
  end
  def movement_end
    puts "#{current_user.email} stopped moving: #{message}"
    return unless message['left'] && message['top']
    Player.find_by_user_id(current_user).update_attributes({
      left:           message['left'],
      top:            message['top'],
      is_moving:      false
    })
  end
end
