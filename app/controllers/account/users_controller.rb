class Account::UsersController < AccountController
  before_action :find_current_user,only: [:index, :edit, :show]

  def index
    render :layout =>'user_panel_order'
  end


  def edit
    @user = User.find(params[:id])
  end


  def show
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

  def find_current_user
     @user = current_user
   end

  def user_params
    params.require(:user).permit(:user_name,:email,:user_avatar,:district,:area,:certificate, :certificate_number)
  end

end
