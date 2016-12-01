class RegistrationsController < Devise::RegistrationsController
 
  def edit
    super
  end


  # 注册后操作
  def after_sign_up_path_for(resource)
    # binding.pry
    # 律师注册
    if current_user.role == "律师"
      # 将律师判断置为true
      current_user.is_lawyer = true
      current_user.save
      # 重定向到律师页面
      edit_lawyer_user_path(current_user)
    # 用户注册
    else
      # 重定向到普通用户页面
      account_questions_path
    end
  end
  #

end
