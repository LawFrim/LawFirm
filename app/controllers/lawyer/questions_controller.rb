class Lawyer::QuestionsController < ApplicationController



    # 必须律师登录才能查看问题
    before_action :authenticate_user!
    before_action :lawyer_required
     before_action :get_mailbox

    layout "lawyer"



    def index
      @user = current_user
      @questions = case params[:order]
        #全部问题按照领域排序
      when 'by_area'
        Question.area
        #全部问题按照地域排序
      when 'by_district'
        Question.district
        #仅显示登陆的律师所在领域的问题
      when 'lawyer_area'
        my_area = @user.area
        Question.where(area:my_area)
        #仅显示登陆的律师所在地区的问题
      when 'lawyer_district'
        my_district = @user.district
        Question.where(district:my_district)

      else
        #所有问题按照最新时间排序
        Question.recent
      end
    end


    #查看问题
    def show
      @question = Question.find(params[:id])
      @answers = @question.answers
      @new_answer = Answer.new

      # f120
      #qid = @question.id.to_s
      # 查是否有关于此问题的回复 
      #dialog = @mailbox.conversations.find_by(subject: qid)
        dialog = @question.conversations.first
      # binding.pry
      if dialog.present?
        # 如果有就交给@message
        @messages = dialog.messages
        @conversation = dialog
      end

    end




end
