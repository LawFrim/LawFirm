class Account::UsersController < ApplicationController
  before_action :authenticate_user!
  layout "user"  



  def index
    @user = current_user
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
      redirect_to account_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name,:email,:user_avatar,:district,:area,:certificate, :certificate_number)
  end

end
