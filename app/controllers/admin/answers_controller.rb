class Admin::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"
  
  # 回答问题
  def create
    @question = Question.find(params[:question_id])
    # 出题人
    akser = @question.user
    # 问题内容和问题id绑定
    subject = @question.id.to_s
    # 回答内容
    answer_content = answer_params[:content]



    # @new_answer = Answer.new(answer_params)
    # @new_answer.user = current_user
    # @new_answer.question = @question
    # if @new_answer.save
    #   flash[:notice] = "回答成功！"
    #   redirect_to :back 
    # else
    #   flash[:alert] = "修改失败!" 
    #   redirect_to :back
    # end

    # mailboxer方法
    conversation = current_user.send_message(akser ,answer_content ,subject).conversation
    # binding.pry
    # 由于没有conversation的model无法进一步设置,并且由于conversation的名字也找不到
    # 所以无法使用适配器,因此只能选择从conversation里面筛选主题的方式来查表
    flash[:notice] = "回复成功"
    redirect_to :back
  end

  # 更新回答
  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to admin_question_path(@question), notice: "答案修改成功!"
    else
      render :back, notice: "答案修改失败!"
    end
  end



  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  # 增加需要管理员登录
  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end


end
