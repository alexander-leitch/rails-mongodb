Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :messages
  resource :wechat, only:[:show,:create]
  
  post "telegram", to: 'telegram#create'
  get "telegram", to: 'telegram#show'
  
  root 'messages#index'
  
  namespace :admin do
    get '/' => 'messages#index'
    resources :messages
  end
  
  mount Facebook::Messenger::Server, at: "bot"
end
