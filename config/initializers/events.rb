WebsocketRails::EventMap.describe do
  subscribe :client_connected,
    to: WebSocketController,
    with_method: :client_connected
  subscribe :client_disconnected,
    to: WebSocketController,
    with_method: :client_disconnected
  subscribe :client_chat,
    to: WebSocketController,
    with_method: :client_chat
  subscribe :starting_position,
    to: WebSocketController,
    with_method: :starting_position
  subscribe :movement,
    to: WebSocketController,
    with_method: :movement
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.
end
