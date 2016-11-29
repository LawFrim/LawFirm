class ModelMailer < ApplicationMailer
  default from: "whenmgonetest@163.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.record_notification.subject
  #
  def record_notification
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # 邮件系统-注册密码
  def send_password_mail(user,password)
    reciver_obj = User.find(user)
    @password = password
    mail to: reciver_obj.email, subject: "Lawyer法律咨询平台-注册"
    # binding.pry
    # message_params =  {
    #                from: 'whenmgonetest@163.com',
    #                to:   reciver_obj.email,
    #                subject: 'Lawyer法律咨询平台',
    #                html:    "<p>您已成功注册，您的当前密码为 <kbd>"+ password +"</kbd> 可以登陆后修改</p>,..."
    #               } 

    # result = mg_client.send_message('whenmgone.com', message_params)
  end
  #

  # 邮件系统-通知
  def send_notification_mail(user,question,question_url)

    reciver_obj = User.find(user)
    # binding.pry
    @question_obj = question
    @url = question_url
    mail to: reciver_obj.email, subject: "Lawyer法律咨询平台-通知"

  end
  # 


end
