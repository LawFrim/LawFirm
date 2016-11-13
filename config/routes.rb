Rails.application.routes.draw do
  devise_for :users

  # 管理员路由
  namespace :admin do
    resources :questions
    resources :answers
  end

  # 普通用户路由
  resources :questions

  resources :conversations

  resources :answers

  root 'questions#index'
end
 
