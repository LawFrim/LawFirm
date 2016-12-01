class AnswersController < ApplicationController
  before_action :authenticate_user!

  # 追加问题
  def create
    @question = Question.find(params[:question_id])
    @new_answer = Answer.new(answer_params)
    @new_answer.user = current_user
    @new_answer.question = @question
    if @new_answer.save
      flash[:notice] = "追加问题成功！" 
      redirect_to question_path(@question)
    else
      flash[:alert] = "修改失败!" 
      redirect_to :back
    end
  end


  private

  # 回答参数
  def answer_params
    params.require(:answer).permit(:content)
  end

end
