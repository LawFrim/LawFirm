class Admin::LawyersController < ApplicationController
  before_action :lawyer_required
  before_action :authenticate_user!

  layout "lawyer"

  # 只显示当前用户的问题
  def index
    @questions = Question.all
  end

  # 查看问题
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @new_answer = Answer.new
  end

# 回答问题
  def create
    @question = Question.find(params[:question_id])
    @new_answer = Answer.new(answer_params)
    @new_answer.user = current_user
    @new_answer.question = @question
    if @new_answer.save
      flash[:notice] = "回答成功！"
      redirect_to :back
    else
      flash[:alert] = "修改失败!"
      redirect_to :back
    end
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



  # 增加需要律师登录
  def lawyer_required
    if !current_user.lawyer?
      redirect_to '/'
    end
  end
end
