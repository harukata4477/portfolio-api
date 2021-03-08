Rails.application.routes.draw do
  namespace :api do
    resources :hello, only:[:index]
  end
end
