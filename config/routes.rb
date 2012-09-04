Phaal::Application.routes.draw do
  devise_for :users

  get 'web_socket/initialize_session'
  root :to => 'high_voltage/pages#show', :id => 'home'
end
