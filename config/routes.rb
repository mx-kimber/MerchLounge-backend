Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
  
  post "/sessions" => "sessions#create"
  resources :users do
    member do
      patch 'change_password', to: 'users#change_password'
      patch 'change_email', to: 'users#change_email'
    end
  end
  
  resources :shops do
    resources :products, only: [:index]
  end
  
  resources :products

  resources :product_images 

end
