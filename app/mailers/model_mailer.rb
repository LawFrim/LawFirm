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
    mail to: reciver_obj.email, subject: "注册成功——伴律网法律咨询"
  end
  #

  # 邮件系统-通知
  def send_notification_mail(user,question,question_url)

    reciver_obj = User.find(user)
    @question_obj = question
    @url = question_url
    mail to: reciver_obj.email, subject: "通知——伴律网法律咨询"

  end
  #


end
