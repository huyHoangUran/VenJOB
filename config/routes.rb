Rails.application.routes.draw do
  # Tránh xung đột với routes của Devise, đặt các routes của Users trước
  get 'my', to: 'users#show'
  get '/registration/:id', to: 'users#edit', as: :edit_user
  patch '/registration/:id/update', to: 'users#update', as: :update_user

  devise_for :users, controllers: {
    registrations: 'registrations'
  }, path: '', path_names: {
    sign_in: 'log_in',
    sign_up: 'register/1'
  }
  
  get 'search', to: 'jobs#search'
  resources :jobs
  resources :cities
  resources :industries
 
  # delete '/users/sign_out', to: 'devise/sessions#destroy'

  devise_scope :user do
    get '/register/2', to: 'registrations#thanks', as: :thanks
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'jobs#index'

  # get '/joblist', to: 'jobs#search', as: 'search'
  # get 'search', to: 'jobs#perform_search', as: 'search_jobs'
  get 'city_jobs', to: 'jobs#city_jobs', as: :city_jobs
  get 'city_search', to: 'jobs#city_search', as: :city_search



end
