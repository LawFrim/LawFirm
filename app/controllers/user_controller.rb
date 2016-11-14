class UserController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create,:update,:edit]

def new
@user = User.new
end

def show
@user = User.find(params[:id])
end

def create
@user = User.new(user_params)
if @user.save
redirect_to :back
else
render :new
end
end

def edit
@user = User.find(params[:id])
end

def update
@user = User.find(params[:id])
if @user.update(user_params)
redirect_to :back
else
render :edit
end
end

private

def user_params
  params.require(:user).permit(:district,:area,:is_admin,:is_lawyer,:id,:email,:encrypted_password,:reset_password_token,:reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip,:created_at,:updated_at)
end
end
