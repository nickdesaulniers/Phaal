class WebSocketController < WebsocketRails::BaseController
  # testing with:
  # var dispatcher = new WebSocketRails('localhost:3000/web_socket/initialize_session');
  def initialize_session
    puts 'initialize session'
  end
  def client_connected
    puts 'client connected'
  end
end
