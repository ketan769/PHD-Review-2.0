Rails.application.routes.draw do
   resources :password_resets
   resources :auths, only: [:new, :create]
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :searches
   root "sessions#new"
   get 'add_user', to: 'searches#add_user'
   get 'user_create', to: 'searches#user_create'
   get 'add_item' ,to: 'searches#add_item'
   get 'item_create' ,to: 'searches#item_create'
   get 'det_update' ,to: 'searches#det_update'
   get 'date' ,to: 'searches#date'
   get 'date_update' ,to: 'searches#date_update'
   get 'studet' ,to: 'searches#studet'
   post 'savepd' ,to: 'searches#savepd'
   get 'showpdf' ,to: 'searches#showpdf'
   get 'doc_up' ,to: 'searches#doc_up'
   post 'savepd2' ,to: 'searches#savepd2'
   get 'show_degree_plan' ,to: 'searches#show_degree_plan'

   get 'view_letter' ,to: 'searches#view_letter'
  resources :reviews
   post 'view_cv' ,to: 'reviews#view_cv'
   get 'view_cv' ,to: 'reviews#view_cv'
   post 'view_dec_letter' ,to: 'reviews#view_dec_letter'
   get 'view_dec_letter' ,to: 'reviews#view_dec_letter'
   post 'savepd3' ,to: 'reviews#savepd3'
end

