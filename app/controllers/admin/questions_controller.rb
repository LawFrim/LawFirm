class Admin::QuestionsController < ApplicationController

  # 必须登录才能回答问题
  before_action :authenticate_user!
  before_action :admin_required

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
  end



  private

  # 增加需要管理员登录
  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end







end
