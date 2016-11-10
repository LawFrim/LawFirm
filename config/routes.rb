Rails.application.routes.draw do
  devise_for :users


  resources :legalmatters do
    resources :comments
  end

  
  
  root 'legalmatters#index'

end
 
