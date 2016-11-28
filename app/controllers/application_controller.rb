class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :get_notification



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
    def after_sign_in_path_for(_user)
      if current_user.is_admin?
        admin_users_path

      elsif   current_user.is_lawyer?
        lawyer_questions_path #你的路径
      else
        account_questions_path
      end
    end


  # 拿到提示

    def after_sign_up_path_for(resource)
       #  account_questions_path #你的路径
       if current_user.is_lawyer?
         lawyer_questions_path
       else
         account_questions_path
       end
      end


  def get_notification
    @notifications ||= Notification.where(recipient: current_user).unread
    # @notifications = current_user.notifications.unread
  end





  # 可继承的方法
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
    # 消息系统中嵌入邮件发送
    send_notification_mail(recipient,notifiable)
  end


  # 邮件系统-通知(使用mailgun客户端)
  def send_notification_mail(user,question)
    mg_client = Mailgun::Client.new

    message_params =  noti_message_params('response',user,question: question)

    result = mg_client.send_message('whenmgone.com', message_params)
  end
  # 


  # 邮件系统-注册密码(使用mailgun客户端)
  def send_password_mail(user,password)
    mg_client = Mailgun::Client.new

    message_params =  noti_message_params('register',user,password: password)

    result = mg_client.send_message('whenmgone.com', message_params)
  end
  # 


  # 消息模板
  def noti_message_params(message_type,reciver,question = nil,password = nil)
    reciver_obj = User.find(reciver)
    question_obj = question.values.last
    case message_type
    # 回复类邮件
    when 'response'
      message_params =  {
                     from: 'whenmgonetest@163.com',
                     to:   reciver_obj.email,
                     subject: 'Lawyer法律咨询平台',
                     html:    '<p>有人回复了问题 <a href="'+ ENV['DOMAIN'] + account_question_path(question_obj.id) +'">' + question_obj.content + '</a></p>...'
                    }  
      return  message_params
    # 注册邮件
    when 'register'
      message_params =  {
                     from: 'whenmgonetest@163.com',
                     to:   reciver_obj.email,
                     subject: 'Lawyer法律咨询平台',
                     html:    '<p>您已成功注册，您的当前密码为 <kbd>'+ password +'</kbd> 可以登陆后修改</p>,...'
                    }  
      return  message_params
    end
  end
  # 




end
