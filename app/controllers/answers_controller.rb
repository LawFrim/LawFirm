class AnswersController < ApplicationController
  before_action :authenticate_user!

  # 追加问题
  def create
    @question = Question.find(params[:question_id])
    @more_question = Answer.new(more_question_params)
    @more_question.user = current_user
    @more_question.question = @question
    @more_question.answer_type = 'morequestion'
    
    # 找到之前的回答，将其状态设置为又被追问了
    @replyanswer = Answer.find(@more_question.reply_for_answer)
    # 如果有前序问题
    if @replyanswer.present?
      @replyanswer.is_replied = true
      @replyanswer.save  
      @more_question.reply_to_user = @replyanswer.user_id    
    end



    

    if @more_question.save
      flash[:notice] = "追加问题成功！" 
      redirect_to question_path(@question)
    else
      flash[:alert] = "修改失败!" 
      redirect_to :back
    end
  end

  private

  # 回答参数
  def more_question_params
    params.require(:answer).permit(:content,:reply_for_answer)
  end





end
