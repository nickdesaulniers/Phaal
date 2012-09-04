Phaal::Application.routes.draw do
  get 'web_socket/initialize_session'
  root :to => 'high_voltage/pages#show', :id => 'home'
end
