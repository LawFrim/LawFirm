class Admin::QuestionsController < ApplicationController
  # before_action :authenticate_user!
  before_action :admin_required
  layout "admin"
  def new
    @question = new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to questions_path
  end

  def index
    @questions = Question.all
  end

  def show
  @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_question_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:description,:answer,:is_answered)
  end

end
