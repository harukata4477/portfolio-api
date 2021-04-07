Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :home, defaults: { format: :json }
  post 'auth_user' => 'authentication#authenticate_user'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    resources :hello, only:[:index]
    resources :follows, only:[:show ,:create, :destroy] do 
      collection do
        get '/show_follower/:id', to: 'follows#show_follower'
      end
    end
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
        get '/room_done/', to: 'rooms#room_done'
        get '/room_not_yet/', to: 'rooms#room_not_yet'
      end
    end
    resources :contents 
    resources :posts do
      collection do
        get '/search/:id', to: 'posts#search'
        get '/post_user/:id', to: 'posts#post_user'
        get '/post_popular/', to: 'posts#post_popular'
      end
    end
    resources :post_contents
    resources :tags
    resources :likes
    resources :messages
    resources :calendars do 
      collection do
        get '/show_month/:id', to: 'calendars#show_month'
      end
    end
    resources :notifications do 
      collection do
        patch '/all_update/', to: 'notifications#all_update'
      end
    end
  end
end
