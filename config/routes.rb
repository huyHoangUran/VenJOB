Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }, path: '', path_names: {
    sign_in: 'log_in'
  }
  
  get 'search', to: 'jobs#search'
  resources :jobs
  resources :cities
  resources :industries
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
  end
  delete '/users/sign_out', to: 'devise/sessions#destroy'

  devise_scope :user do
    get '/thanks', to: 'registrations#thanks', as: :thanks
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'jobs#index'

  # get '/joblist', to: 'jobs#search', as: 'search'
  # get 'search', to: 'jobs#perform_search', as: 'search_jobs'
  get 'city_jobs', to: 'jobs#city_jobs', as: :city_jobs
  get 'city_search', to: 'jobs#city_search', as: :city_search



end
