Rails.application.routes.draw do
  # get 'jobs/search'
  get 'search', to: 'jobs#search'
  resources :jobs

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'jobs#index'
end
