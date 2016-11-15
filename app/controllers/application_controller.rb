class ApplicationController < ActionController::Base
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

end
