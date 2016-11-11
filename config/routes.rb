Rails.application.routes.draw do
  devise_for :users

  # 管理员路由
  namespace :admin do
    resources :questions do
      resources :answers
      collection do
        get :area
        get :district
      end
    end

  end

  # 普通用户路由
  resources :questions do
    resources :answers
  end



  root 'questions#index'
end
