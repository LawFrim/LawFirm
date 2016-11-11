class QuestionsController < ApplicationController
before_action :authenticate_user!,only:[:index,:show] #路人不能看到问题清单和问题内容
  def index
    @questions = Question.all
    @user = User.all
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save!
    redirect_to questions_path
    else
    render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end


  private

  def question_params
    params.require(:question).permit(:description,:answer,:is_answered)
  end
end
