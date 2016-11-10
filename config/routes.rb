Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :questions
  end

  resources :questions
root'questions#show'  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
