class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 #devise i18n
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  # Get locale from top-level domain or return nil if such locale is not available
  # You have to put something like:
  #   127.0.0.1 application.com
  #   127.0.0.1 application.it
  #   127.0.0.1 application.pl
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
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
