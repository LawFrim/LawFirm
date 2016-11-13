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
    @answers = @question.answers

    # 把自己的回答和用户的追问筛选出来
    @answers_for_current_user = @answers.about_me(current_user)


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
