Rails.application.routes.draw do
  # Tránh xung đột với routes của Devise, đặt các routes của Users trước
  get 'my', to: 'users#show'
  get 'registration/3', to: 'users#edit'
  get 'my/info', to: 'users#editInfo'
  patch 'users/updateInfo', to: 'users#updateInfo'
  patch 'users/update', to: 'users#update', as: :update_user
  devise_for :users, controllers: {
    registrations: 'registrations',
    passwords: 'passwords'
  }, path: '', path_names: {
    sign_in: 'log_in',
    sign_up: 'register/1',
  }
  
  get 'search', to: 'jobs#search'
  resources :jobs
  resources :cities
  resources :industries
  devise_scope :user do
    get 'register/2', to: 'registrations#thanks'
  end
  resources :favourites, only: [:create, :destroy, :index]
  root 'jobs#index'
  get 'city_jobs', to: 'jobs#city_jobs', as: :city_jobs
  get 'city_search', to: 'jobs#city_search', as: :city_search

end
