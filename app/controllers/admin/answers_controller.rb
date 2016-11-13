class Admin::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"
  
  # 回答问题
  def create
    @new_answer = Answer.new(answer_params)
    @new_answer.user = current_user

    # 如果会话id不存在，说明这没有人回答，那就先新建一个会话id
    if @new_answer.conversation_id.blank?
      @question = Question.find(@new_answer.question_id)
      @conversation = Conversation.new
      @conversation.update(question_id: @new_answer.question_id,lawyer_id: @new_answer.user_id,client_id: @question.user_id)
      
      # binding.pry
      @new_answer.conversation_id = @conversation.id
    end

    # 找到之前的回答，将其状态设置为又被追问了
    if @new_answer.reply_for_answer.present?
      @replyquestion = Answer.find(@new_answer.reply_for_answer)
    # 如果有前序问题，就将前序追问状态调整
      @replyquestion.present?
      @replyquestion.is_replied = true
      @replyquestion.save  
      @new_answer.reply_to_user = @replyquestion.user_id    
    end


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
    params.require(:answer).permit(:content,:reply_for_answer,:conversation_id,:question_id)
  end

  # 增加需要管理员登录
  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end


end
