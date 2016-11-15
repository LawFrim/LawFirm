class Admin::QuestionsController < ApplicationController

  # 必须登录才能回答问题
  before_action :authenticate_user!
  before_action :admin_required
  before_action :get_mailbox

  layout "admin"
  # 只显示当前用户的问题
  def index
    @questions = case params[:order]
    when 'by_area'
      Question.area
    when 'by_district'
      Question.district
    else
      Question.recent
    end
  end


  # 查看问题
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @new_answer = Answer.new
    
    # f120
    qid = @question.id.to_s
    # 查是否有关于此问题的回复
    dialog = @mailbox.conversations.find_by(subject: qid)
    # binding.pry
    if dialog.present?
      # 如果有就交给@message
      @messages = dialog.messages
      @conversation = dialog
    end

  end



  private

end
