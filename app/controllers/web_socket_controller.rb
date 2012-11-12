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
  def client_disconnected
    puts "client #{current_user.email} disconnected"
  end
  def message_received
    puts "Received message #{message} of type #{message.class} from user " +
      current_user.email
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
  def movement
    puts "#{current_user.email} started moving: #{message}"
  end
end
