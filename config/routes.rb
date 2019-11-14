Rails.application.routes.draw do
   resources :password_resets

   resources :auths, only: [:new, :create]
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :searches
  root "searches#new"
  resources :reviews

end
