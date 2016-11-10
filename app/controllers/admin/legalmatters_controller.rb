class Admin::LegalmattersController < ApplicationController

  before_action :authenticate_user!

  def index
    @legalmatters = Legalmatter.all
  end




  def new
    @legalmatter = Legalmatter.new
  end

  def show
    @legalmatter = Legalmatter.find(params[:id])
    @comments = @legalmatter.comments
    @new_comment = Comment.new
  end

  def edit
    @legalmatter = Legalmatter.find(params[:id])
  end


  def create
    @legalmatter = Legalmatter.new(legalmatter_params)
    @legalmatter.user = current_user
    if @legalmatter.save
      redirect_to legalmatters_path, notice: "问题已发布!"
    else
      render :new
    end
  end

  def update
    @legalmatter = Legalmatter.new(legalmatter_params)
    @legalmatter.user = current_user
    if @legalmatter.update(legalmatter_params)
      redirect_to legalmatters_path, notice: "问题已修改!"
    else
      render :new
    end
  end


  private

  def legalmatter_params
    params.require(:legalmatter).permit(:question)
  end

  def comment_params
    params.require(:comment).permit(:answer)
  end



end
