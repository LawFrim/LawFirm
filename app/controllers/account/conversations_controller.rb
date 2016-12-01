class Account::ConversationsController < AccountController
  before_action :find_question_and_conversation, only: [:show, :show_lawyer]

  def show
    @messages = @conversation.messages.order(created_at: :ASC)
    # binding.pry
    @new_answer = Answer.new
    # binding.pry
  end

  # 显示律师信息
  def show_lawyer
    @conversation = @question.conversations.find(params[:id])
    @lawyer = @conversation.originator
    # binding.pry
    # 获取律师评价值
    @lawyer_rating = average_rating(@lawyer)
  end

  # 追问问题
  def create
    # 如果用户是不是vip
    # 而且是当前用户已经问过了问题或者是第一个问题的追问，就重定向用户
    if !current_user.is_vip && (current_user.questions.present?)
      redirect_to price_path
    else

      # 
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
     
      # binding.pry
      if conversation_id.blank?
        # 其实上面这段if永远不会被调用，因为用户不会发起一个message
        conversation = current_user.send_message(akser ,answer_content ,subject,@question,true,attachment).conversation
          # xdite魔改后的send_message多了一个question参数
        send_notification!(recipient, akser, notifiable)

      else
        # 通过会话id获取会话
        conversation = @question.conversations.find(conversation_id)
        # binding.pry

        current_user.reply_to_conversation(conversation, answer_content,nil,true,true,attachment)

        # 客户发给律师提醒追问

        send_notification!(conversation.originator.id, current_user.id, @question)
      end
      # binding.pry
      # f470-变成待回答状态
      @question.reopened!
      # binding.pry
      flash[:notice] = "回复成功"
      redirect_to :back
      # 

    end

  end


  private

  def find_question_and_conversation
    @question = Question.find(params[:question_id])
    # 根据id查找到指定对话
    @conversation = @question.conversations.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content,:conversation_id,:attachment)
  end


end
