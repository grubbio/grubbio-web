GrubbioWeb::Application.routes.draw do

  devise_for  :users, 
              controllers: { 
                registrations: "users/registrations", 
                sessions: "users/sessions"
              }

  resources :users

  resources :markets

  resources :food_products
  
  root :to => 'pages#index'



end
