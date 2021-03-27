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
        get '/user_post/:id', to: 'users#user_post'
      end
    end
    resources :rooms do
      collection do
        get '/search/:id', to: 'rooms#search'
        get '/all/', to: 'rooms#all'
      end
    end
    resources :contents 
    resources :posts do
      collection do
        get '/search/:id', to: 'posts#search'
        get '/post_user/:id', to: 'posts#post_user'
        get '/post_like/:id', to: 'posts#post_like'
      end
    end
    resources :post_contents
    resources :tags
    resources :likes
  end
end
