class Lawyer::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :lawyer_required
  layout "lawyer"


  def index
    @user = current_user
    @lawyer_rating = average_rating(current_user)
  end


  def edit
    @user = current_user
    @user = User.find(params[:id])
  end


  def show
    @user = current_user

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to lawyer_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name,:email,:user_avatar,:district,:area,:lawfirm,:certificate,:certificate_number)
  end

end
