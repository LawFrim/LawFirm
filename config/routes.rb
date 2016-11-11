Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :legalmatters do
      resources :comments
    end
  end

  resources :legalmatters do
    resources :comments
  end

  
  
  root 'legalmatters#index'

end
 
