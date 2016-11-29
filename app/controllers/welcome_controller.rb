class WelcomeController < ApplicationController
 
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

    # 看这个用户是否之前建立过




    # 建立新用户
    user = User.find_by(email: new_user_email)
    if user.blank?
      user =  User.create(:email => new_user_email, :password => generated_password)
      binding.pry
      # send_password_mail(user.id,generated_password)
      
      ModelMailer.send_password_mail(user.id,generated_password).deliver
      # 为这个用户建立新问题
      question = Question.create(content: new_quesion_content, user: user)
      flash[:notice] = "请查收邮箱获取默认密码！"

      
      # 用户登录
      sign_in user
      # 用户重定向
      redirect_to account_questions_path

    else
      # 如果是已存在用户让他登录
      redirect_to new_user_session_path
    end
  end


  private

  # 接收用户的临时问题
  def temp_question_params
    params.require(:temp_question).permit(:email,:content)
  end

end
