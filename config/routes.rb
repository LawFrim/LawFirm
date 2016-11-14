Rails.application.routes.draw do
  devise_for :users

  # 管理员路由
  namespace :admin do
    resources :questions do
      resources :answers
    end
    resources :conversations

  end

  # 普通用户路由
  namespace :account do
    resources :documents
    resources :questions do
      resources :answers
      resources :conversations
    end
    
  end



  root 'account/questions#index'
end
