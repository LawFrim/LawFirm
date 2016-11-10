class Admin::QuestionsController < ApplicationController
  def new
    @question = new
  end

  def index
    @questions = Question.all
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
    params.require(:question).permit(:description,:answer)
  end
end
