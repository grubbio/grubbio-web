GrubbioWeb::Application.routes.draw do

  devise_for  :users, 
              controllers: { 
                registrations: "users/registrations", 
                sessions: "users/sessions"
              }

  resources :users
  
  resources :businesses do
    resource :business_profile
  end

  #resources :markets

  resources :food_products
  
  match '/food', to: 'food#index'
  match '/food/:id/:name', to: 'food#show'

  resources :product_categories do
    resources :food_products
  end

  root :to => 'pages#index'

  resources :markets do
  	get :autocomplete_market_market_name, :on => :collection
	end
end
