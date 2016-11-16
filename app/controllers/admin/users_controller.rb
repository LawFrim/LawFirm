class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"
  def index
    @users =  case params[:order]
    when 'by_lawyer'
      User.lawyer
    when 'by_account'
      User.account
    else
      User.all
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert]="User deleted."
    redirect_to :back
  end





  def change_to_user
    @user = User.find(params[:id])
    @user.is_lawyer= false
    redirect_to :back
  end

  def change_to_lawyer
    @user = User.find(params[:id])
    @user.is_lawyer = true
    redirect_to :back
  end




end
