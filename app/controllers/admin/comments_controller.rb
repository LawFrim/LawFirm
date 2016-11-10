class Admin::CommentsController < ApplicationController

  before_action :authenticate_user!

  def show
    @legalmatter = Legalmatter.find(params[:id])
    @comments = @legalmatter.comments
    @advise = Comment.new
  end

  def create
    @legalmatter = Legalmatter.find(params[:legalmatter_id])
    @new_comment = Comment.new(comment_params)
    @new_comment.user = current_user
    @new_comment.legalmatter = @legalmatter
    if @new_comment.save
      flash[:notice] = "回答成功！" 
      redirect_to legalmatters_path
    else
      flash[:alert] = "修改失败!" 
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:answer)
  end


end
