Rails.application.routes.draw do
  # get 'products/index'
  resources :products
  # get 'products/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
end
