class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception




  # 建一个邮箱
  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

end
