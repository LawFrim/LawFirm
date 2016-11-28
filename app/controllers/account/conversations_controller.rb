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

    # binding.pry
  end

  def show_lawyer
    @question = Question.find(params[:question_id])
    @conversation = @question.conversations.find(params[:id])
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
    # 获取附件
    attachment = answer_params[:attachment]
    # mailboxer方法
    # 如果之前没有对话，就新建对话。如果有，就回复对话
    puts '~~~~'
    puts attachment
    puts '~~~~'
    # binding.pry

    if conversation_id.blank?
      # 其实上面这段if永远不会被调用，因为用户不会发起一个message
      conversation = current_user.send_message(akser ,answer_content ,subject,@question,true,attachment).conversation
        # xdite魔改后的send_message多了一个question参数
      # send_notification!(recipient, akser, notifiable)

    else
      # 通过会话id获取会话
      conversation = @question.conversations.find(conversation_id)
      # binding.pry
      puts '!!!!!!!!'
      current_user.reply_to_conversation(conversation, answer_content,nil,true,true,attachment)
      puts '!!!!!!!!'
      # 客户发给律师提醒追问
      send_notification!(conversation.originator.id, current_user.id, @question)
    end


    # binding.pry

    # f470-变成待回答状态
    @question.reopened!

    # binding.pry
    flash[:notice] = "回复成功"
    redirect_to :back
  end





  private

  def answer_params
    params.require(:answer).permit(:content,:conversation_id,:attachment)
  end
end
