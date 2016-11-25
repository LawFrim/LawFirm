class RegistrationsController < Devise::RegistrationsController
  layout 'welcome'

  def edit
    super
  end

  protected
  def after_update_path_for(user)
    # admin_users_path #你的路径
    if current_user.is_lawyer?
      lawyer_questions_path #你的路径
    elsif current_user.is_admin?
      admin_users_path
    else
      account_questions_path
    end
 end

 def after_sign_up_path_for(resource)
    #  account_questions_path #你的路径
    if current_user.is_lawyer?
      lawyer_questions_path #你的路径
    elsif current_user.is_admin?
      admin_users_path
    else
      account_questions_path
    end
   end
end
