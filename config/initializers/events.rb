# You can use this file to map incoming events to controller actions.
# One event can be mapped to any number of controller actions. The
# actions will be executed in the order they were subscribed.
WebsocketRails::EventMap.describe do
  def sub event_symbol
    subscribe event_symbol, to: WebSocketController, with_method: event_symbol
  end
  sub :client_connected
  sub :client_disconnected
  sub :client_chat
  sub :starting_position
  sub :movement_start
  sub :movement_end
end
