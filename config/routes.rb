Rails.application.routes.draw do
  # root "static_pages#home"
  devise_for :users

  as :user do
    get 'signin' => 'devise/sessions#new'
    post 'signin' => 'devise/sessions#create'
    # delete 'signout' => 'devise/sessions#destroy'
  end
  delete '/users/sign_out', to: 'devise/sessions#destroy'

  # get 'products/index'
  resources :products
  # get 'products/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
end
