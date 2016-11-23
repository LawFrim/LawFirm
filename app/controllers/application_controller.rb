class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
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


    #不同用户登录后跳转到指定页面
    def after_sign_in_path_for(lawyer_user)
      if current_user.is_lawyer?
        lawyer_questions_path #你的路径
      elsif current_user.is_admin?
        admin_users_path
      else
        account_questions_path
      end
    end

  protected
   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
     devise_parameter_sanitizer.permit(:account_update, keys: [:role])
   end

  # f783-addNotificationToNavbar
  # recipient 接收者
  # actor 发起者
  # notifiable_id  哪张表发起的  比如，question要提醒用户，这里就传question
  # notifiable_type  发起的请求类型，比如如果是"question", 就填"question"
  # 发送信息
  def send_notification!(recipient, actor, notifiable)
    puts notifiable.class
    Notification.create(recipient_id: recipient, actor_id: actor, notifiable_id: notifiable.id, notifiable_type: notifiable.class)
    # binding.pry
  end

end
