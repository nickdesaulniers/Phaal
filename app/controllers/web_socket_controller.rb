class WebSocketController < WebsocketRails::BaseController
  # testing with:
  # var dispatcher = new WebSocketRails('localhost:3000/websocket');
  def initialize_session
    puts 'initialize session'
  end
  def client_connected
    puts 'client connected'
  end
end
