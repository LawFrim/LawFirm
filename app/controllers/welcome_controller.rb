class WelcomeController < ApplicationController

  def index
    # flash[:notice] = "早安！你好！"
    # 给个可以发临时问题的页面，可以接收问题和用户邮箱
    @temp_question = TempQuestion.new
  end

  def mapguide
  end
  def aboutus
  end
  def joinus
  end
  

  def show
  end


  # 获取路人问题
  def get_temp_question
    # 接收用户的问题
    temp_queston = TempQuestion.create(temp_question_params)
    new_user_email = temp_question_params[:email]
    new_quesion_content = temp_question_params[:content]

    # hash用户的密码
    generated_password = Devise.friendly_token.first(8)

    # 看这个用户是否之前建立过




    # 建立新用户
    user = User.find_by(email: new_user_email)
    if user.blank?
      user =  User.create(:email => new_user_email, :password => generated_password)
      # send_password_mail(user.id,generated_password)

      ModelMailer.send_password_mail(user.id,generated_password).deliver
      flash[:notice] = "请查收邮箱获取密码！"
    else
      flash[:notice] = "您的问题已发布！"
    end

    # 发送邮件通知用户新密码
    # binding.pry


    # 为这个用户建立新问题
    question = Question.create(content: new_quesion_content, user: user)
    puts 'build question success!!!'

    # 重定向到首页

    redirect_to '/'
  end


  private

  # 接收用户的临时问题
  def temp_question_params
    params.require(:temp_question).permit(:email,:content)
  end

end
