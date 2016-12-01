class RegistrationsController < Devise::RegistrationsController
  layout 'welcome'
  def edit
    super
  end

  protected
  def after_update_path_for(user)
    if current_user.is_admin?
      admin_users_path# admin_users_path #你的路径
    elsif
      current_user.is_lawyer?
        lawyer_user_path #你的路径
    else
      account_user_path
    end
 end

 def after_sign_up_path_for(user)
    #  account_questions_path #你的路径
    if current_user.is_admin?
      admin_users_path
    elsif
      current_user.is_lawyer?
      lawyer_user_path #你的路径
    else
      account_user_path
    end
   end
end
