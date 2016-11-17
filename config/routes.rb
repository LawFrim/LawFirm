Rails.application.routes.draw do
  #用户修改密码
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # 管理员路由
  namespace :admin do
    resources :questions do
      resources :answers
    end
    resources :conversations
    resources :users do
      member do
        post :change_to_user
        post :change_to_lawyer
      end
    end
  end

  # 普通用户路由
  namespace :account do
    resources :documents
    resources :users
    resources :questions do
      resources :answers
      resources :conversations

    end

  end

  # 律师路由
  namespace :lawyer do
    resources :users
    resources :questions do

        resources :answers
    end
    resources :documents do
      resources :feedbacks
    end

  end



  resources :welcome
  root 'welcome#index'

end
