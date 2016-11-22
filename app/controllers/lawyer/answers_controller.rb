class Lawyer::AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :lawyer_required
  before_action :get_mailbox

  layout "lawyer"

  # 回答问题
  def create
    @question = Question.find(params[:question_id])
    # 出题人
    akser = @question.user
    # 问题内容和问题id绑定
    subject = @question.content
    # 回答内容
    answer_content = answer_params[:content]

    # 对话id
    conversation_id = answer_params[:conversation_id]
    # mailboxer方法
    # 如果之前没有对话，就新建对话。如果有，就回复对话

    if conversation_id.blank?
      # 使用修正过得新send_message多加了一个参数
      conversation = current_user.send_message(akser ,answer_content ,subject , @question).conversation
      # 发送给用户回答问题的提醒
      send_notification!(akser.id, current_user.id, @question)
      # binding.pry

    else
      # 通过会话id获取会话
      conversation = @question.conversations.find(conversation_id)
      # binding.pry
      current_user.reply_to_conversation(conversation, answer_content)
      # 发送给用户回答问题的提醒
      send_notification!(akser.id, current_user.id, @question)
      # binding.pry

    end

    # f470-变成已回答状态
    @question.answered!

    # binding.pry
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
    params.require(:answer).permit(:content,:conversation_id)
  end

end
