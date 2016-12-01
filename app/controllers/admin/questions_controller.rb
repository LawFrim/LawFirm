class Admin::QuestionsController < AdminController
  # 只显示当前用户的问题
  def index
    @user = current_user
    @questions = case params[:order]
    when 'by_area'
      Question.area
    when 'by_district'
      Question.district
    when "lawyer_area"
      my_area = @user.area
      Question.where(area:my_area)
    when  "lawyer_district"
      my_district = @user.district
      Question.where(district:my_district)
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
    # qid = @question.id.to_s
    # 查是否有关于此问题的回复
    dialog = @question.conversations.first
    # binding.pry
    if dialog.present?
      # 如果有就交给@message
      @messages = dialog.messages
      @conversation = dialog
    end
  end




end
