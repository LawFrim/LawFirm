class LegalmattersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required


  # 只显示当前用户的问题
  def index
    @legalmatters = Legalmatter.where(user_id: current_user)
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
    @legalmatter = Legalmatter.find(params[:id])
    @legalmatter.user = current_user
    if @legalmatter.update(legalmatter_params)
      redirect_to legalmatter_path(@legalmatter), notice: "问题已修改!"
    else
      render :back, notice: "修改失败!"
    end
  end


  private

  def legalmatter_params
    params.require(:legalmatter).permit(:question)
  end

  def comment_params
    params.require(:comment).permit(:answer)
  end

  def admin_required
    if current_user.admin?
      redirect_to admin_legalmatters_path
    end
  end


end
