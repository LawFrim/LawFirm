class Lawyer::QuestionsController < LawyerController


    def index
      @user = current_user
      @questions = case params[:order]
        #全部问题按照领域排序

        # when 'by_area'
        #   Question.area
        #   #全部问题按照地域排序
        # when 'by_district'
        #   Question.district
        #   #仅显示登陆的律师所在领域的问题
        # when 'lawyer_area'
        #   my_area = @user.area
        #   Question.where(area:my_area)
        #   #仅显示登陆的律师所在地区的问题
        # when 'lawyer_district'
        #   my_district = @user.district
        #   Question.where(district:my_district)
        # #仅显示登陆的律师所在地区及领域的问题并显示最新时间排序
        # when 'lawyer_two'
        #   my_district = @user.district
        #   my_area = @user.area
        #   Question.where(district:my_district,area:my_area).recent
        # f1195-fixLawyerQuestionSystem
        # 可回答问题
        when 'waiting_for_answer'
          # my_district = @user.district
          # my_area = @user.area
          fliter_questions = Question.all
          waiting_questions =  fliter_questions - current_user.answered_questions
          # puts waiting_questions
          # 数组按时间倒序排列
          waiting_questions.sort_by{ |i| i.created_at }.reverse
        # 答过的问题
        when 'already_answered'
          # 数组按时间倒序排列
          current_user.answered_questions.sort_by{ |i| i.created_at }.reverse
        #
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

      # 查是否有关于此问题的回复
      dialog = @mailbox.conversations.find_by(question_id: @question)

      # binding.pry
      if dialog.present?
        # 如果有就交给@message
        # 生产异常message序列，使用逆序
        @messages = dialog.messages.order(created_at: :ASC)

        # binding.pry
        @conversation = dialog
      end

    end




end
