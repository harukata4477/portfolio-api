Rails.application.routes.draw do
  resources :home, defaults: { format: :json }
  post 'auth_user' => 'authentication#authenticate_user'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    resources :hello, only:[:index]
    resources :follows, only:[:show ,:create, :destroy]
    resources :users do
      collection do
        get '/search/:id', to: 'users#search'
      end
    end
  end
end
