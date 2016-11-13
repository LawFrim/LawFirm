class Admin::QuestionsController < ApplicationController
  
  # 必须登录才能回答问题
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"
  # 只显示当前用户的问题
  def index
    @questions = Question.all
  end


  # 查看问题
  def show
    @question = Question.find(params[:id])
    # 找到律师针对这个问题的会话记录
    @conversation = @question.conversations.find_by(lawyer_id: current_user.id)
    # 如果之前回答过该问题(即该会话存在)，则列出所有内容
    if @conversation.present?
      @answers = @conversation.answers
    end
    @new_answer = Answer.new
  end



  private

  # 增加需要管理员登录
  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end







end
