Rails.application.routes.draw do
  # Routes for main resources
  resources :stores
  resources :employees
  resources :assignments
  resources :jobs
  resources :shifts
  resources :flavors
  resources :users
  resources :sessions
  resources :shift_jobs


  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout  
  
  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'home/dashboard' => 'home#dashboard', :as => :dashboard
  get 'home/manage_shifts' => 'home#manage_shifts', :as => :myshifts

  
  # Set the root url
  root :to => 'home#home'  
  
end
