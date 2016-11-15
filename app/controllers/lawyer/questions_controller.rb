class Lawyer::QuestionsController < ApplicationController



    # 必须律师登录才能回答问题
    before_action :authenticate_user!
    before_action :lawyer_required
     before_action :get_mailbox

    layout "lawyer"
    # 只显示当前用户的问题


    # def index
    #   @questions = case 'by_recent'
    #   when 'by_area'
    #     Question.area
    #   when 'by_district'
    #     Question.district
    #   else
    #     Question.recent
    #   end
    # end


    # 显示当前用户律师所在区域的问题
    def index
      @questions = Question.all
    end
     # 按照地域排序律师的问题
    def index
      @questions = case params[:order]
      when 'by_area1'
        Question.area
      when 'by_district1'
        Question.district
      else
        Question.recent
      end
    end

    #
    #查看问题
    def show
      @question = Question.find_by(district: '北京')
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

      def show_district
      @questions = Question.where(district: '北京')

      end



    private

    # 问题参数
    def question_params
      params.require(:question).permit(:content,:area,:district)
    end

    # 答案参数
    def answer_params
      params.require(:answer).permit(:content)
    end


    #建一个邮箱
    def get_mailbox
      @mailbox ||= current_user.mailbox
    end



end
