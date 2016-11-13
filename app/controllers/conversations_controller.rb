class ConversationsController < ApplicationController
  # 必须登录才能问问题
  before_action :authenticate_user!

  # 会话对应的具体问题
  def show
    @conversation = Conversation.find(params[:id])
    @answers = @conversation.answers
    @more_question = Answer.new
  end

end
