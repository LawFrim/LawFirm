class Admin::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :get_mailbox

  layout "admin"

  # 回答问题
  def create
    @question = Question.find(params[:question_id])
    # 出题人
    asker = @question.user
    # 问题内容和问题id绑定
    subject = @question.id.to_s
    # 回答内容
    answer_content = answer_params[:content]

    # 对话id
    conversation_id = answer_params[:conversation_id]
    # mailboxer方法
    # 如果之前没有对话，就新建对话。如果有，就回复对话

    if conversation_id.blank?
      conversation = current_user.send_message(asker, answer_content, @question.content, @question).conversation
    # 由于没有conversation的model无法进一步设置,并且由于conversation的名字也找不到
    # 所以无法使用适配器,因此只能选择从conversation里面筛选主题的方式来查表
    else
      # 通过会话id获取会话
      conversation = @question.conversation
      # binding.pry
      current_user.reply_to_conversation(conversation, answer_content)
    end

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
    params.require(:answer).permit(:content, :conversation_id)
  end

  # 增加需要管理员登录
  def admin_required
    redirect_to "/" unless current_user.admin?
  end

  # 建一个邮箱
  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
