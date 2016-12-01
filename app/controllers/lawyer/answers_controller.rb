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
    # 获取附件
    attachment = answer_params[:attachment]
    # 对话id
    conversation_id = answer_params[:conversation_id]

    # mailboxer方法
    # 如果之前没有对话，就新建对话。如果有，就回复对话
    if conversation_id.blank?
      # 使用修正过得新send_message多加了一个参数
      conversation = current_user.send_message(akser ,answer_content ,subject , @question,true,attachment).conversation
      # 发送给用户回答问题的提醒
      send_notification!(akser.id, current_user.id, @question)
    else
      # 通过会话id获取会话
      conversation = @question.conversations.find(conversation_id)
      # binding.pry
      current_user.reply_to_conversation(conversation, answer_content,nil,true,true,attachment)
      # 发送给用户回答问题的提醒
      send_notification!(akser.id, current_user.id, @question)
    end
    # 

    # 更新律师与问题的多对多回答表
    lawyer_answer_question = LawyerAnsweredQuestion.new
    lawyer_answer_question.lawyer = current_user.lawyer
    lawyer_answer_question.question = @question
    lawyer_answer_question.save
    # 

    # f470-变成已回答状态
    @question.answered!

    flash[:notice] = "回复成功"
    redirect_to :back
  end

  private

  def answer_params
    params.require(:answer).permit(:content,:conversation_id,:attachment)
  end

end
