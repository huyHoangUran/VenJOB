Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "jobs#index"
  resources :jobs

  resources :jobs do
    collection { post :import }
  end
  get "search", to: "jobs#search"

end
