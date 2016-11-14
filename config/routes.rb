Rails.application.routes.draw do
  devise_for :users

  # 管理员路由
  namespace :admin do
    resources :questions do
      resources :answers
    end

  end

  # 普通用户路由
  namespace :account do
    resources :questions do
    resources :answers
  end
  end


  resources :questions
  root 'welcome#index'
end
