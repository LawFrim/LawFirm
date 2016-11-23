class RegistrationsController < Devise::RegistrationsController
  protected
  def after_update_path_for(user)
    admin_users_path #你的路径
  end
  def after_sign_up_path_for(resource)
    account_questions_path #你的路径
  end
end
