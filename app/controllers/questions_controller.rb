class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
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
