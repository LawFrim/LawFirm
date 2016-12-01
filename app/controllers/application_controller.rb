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

      elsif current_user.is_lawyer?
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
    # send_notification_mail(recipient,notifiable)s
    user = User.find(recipient)
    if user.lawyer?
      question_url = ENV['DOMAIN_NAME'] + lawyer_question_path(@question)
    else
      question_url = ENV['DOMAIN_NAME'] + account_question_path(@question)
    end


    # 只有生产环境才发邮件
    if Rails.env == 'production'
      # 邮箱发送提醒信件
      ModelMailer.send_notification_mail(recipient, @question,question_url).deliver_later          
    end

  end


  # 星星评级
  def average_rating(lawyer)
    # 获取到所有的对话
    conversations = lawyer.mailbox.conversations
    # 遍历每个对话的rating并将其加和，最后除总数
    
    # 设置初始值
    sum_raty = 0
    sum_count = 0

    conversations.each do |c|
      # 先筛选出每个对话中其中有rating的message
      messages = c.messages.where.not(rating: nil)
      # 得到总的raty值
      total_raty = 0
      messages.each do |m|
        total_raty = total_raty + m.rating
      end

      # 加总
      sum_count = sum_count + messages.count
      sum_raty = sum_raty + total_raty

    end
    # 相除得到平均值
    return (sum_raty.to_f/sum_count).round(1)


  end



end
