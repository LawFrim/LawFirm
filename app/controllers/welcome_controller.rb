class WelcomeController < ApplicationController
<<<<<<< HEAD
  layout 'welcome'
  
=======
 # layout 'welcome'
>>>>>>> develop
  def index
    # flash[:notice] = "早安！你好！"
    # 给个可以发临时问题的页面，可以接收问题和用户邮箱
    @temp_question = TempQuestion.new
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
    # 建立新用户
    user = User.new
    user.email = new_user_email
    user.password = generated_password
    user.password_confirmation = generated_password
    user.save
    # User.create(:email => new_user_email, :password => generated_password)
    
    # 发送邮件通知用户新密码
    # binding.pry
    send_password_mail(user.id,generated_password)

    # 为这个用户建立新问题
    question = Question.new
    question.content = new_quesion_content
    question.user = user
    question.save
    puts 'build question success!!!'

    # 重定向到首页
    flash[:notice] = "请查收邮箱获取密码！"
    redirect_to '/' 
  end


  private

  # 接收用户的临时问题
  def temp_question_params
    params.require(:temp_question).permit(:email,:content)
  end

end
