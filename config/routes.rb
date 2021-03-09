Rails.application.routes.draw do
  resources :home, defaults: { format: :json }
  post 'auth_user' => 'authentication#authenticate_user'
  mount_devise_token_auth_for 'User', at: 'auth', defaults: { format: :json }
  namespace :api, defaults: { format: :json } do
    resources :hello, only:[:index]

  end
end
