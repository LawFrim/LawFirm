class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception



  # 增加需要管理员登录
  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end


  # 建一个邮箱
  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def lawyer_required
     if !current_user.lawyer?
      redirect_to "/"
      end
   end
  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
     devise_parameter_sanitizer.permit(:account_update, keys: [:role])
   end

end
