class Account::ConversationsController < ApplicationController
  # 必须登录才能问问题
  before_action :authenticate_user!
  # f120
  before_action :get_mailbox
  layout "user"

  def show
    @question = Question.find(params[:question_id])
    # 根据id查找到指定对话
    @conversation = @question.conversations.find(params[:id])
    @messages = @conversation.messages
    # binding.pry

    @new_answer = Answer.new

  end



  # 追问问题
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
      conversation = current_user.send_message(akser ,answer_content ,subject,@question).conversation
        # xdite魔改后的send_message多了一个question参数
    else
      # 通过会话id获取会话
      conversation = @question.conversations.find(conversation_id)
      # binding.pry
      current_user.reply_to_conversation(conversation, answer_content)
    end

    # binding.pry
    flash[:notice] = "回复成功"
    redirect_to :back
  end






  private

  def answer_params
    params.require(:answer).permit(:content,:conversation_id)
  end
end
