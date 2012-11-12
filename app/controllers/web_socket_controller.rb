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
  
  # When the client connects, give them their initial coordinates
  def client_connected
    puts "client #{current_user.email} connected"
    player = current_user.player || current_user.create_player
    coords = [player.left, player.top]
    puts "sending coordinates #{coords}"
    send_message :starting_position, coords
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
    player = Player.find_by_user_id current_user
    player.left = message['left']
    player.top  = message['top']
    player.last_direction = message['direction']
    player.save
  end
  def movement_end
    puts "#{current_user.email} stopped moving: #{message}"
    return unless message['left'] && message['top']
    player = Player.find_by_user_id current_user
    player.left = message['left']
    player.top  = message['top']
    player.save
  end
end
