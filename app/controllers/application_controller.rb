class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 修改密码
  before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u|
        u.permit(:password, :password_confirmation, :current_password)
      }
    end


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


end
