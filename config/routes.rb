Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'about' => 'pages#about'

  resources :posts do
   resources :comments
  end
  resources :users

  put 'vote' => 'posts#vote'


  match ':controller(/:action(/:id))', :via => :get

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
