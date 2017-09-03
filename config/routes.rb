Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :products
  resources :posts
  
  resources :messages
  resource :wechat, only:[:show,:create]
  
  post "telegram", to: 'telegram#create'
  get "telegram", to: 'telegram#show'
  
  root 'posts#index'
  
  namespace :admin do
    get '/' => 'posts#index'
    resources :products
    resources :posts
    resources :messages
  end
  
  mount Facebook::Messenger::Server, at: "bot"
end
