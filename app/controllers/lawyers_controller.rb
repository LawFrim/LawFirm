class LawyersController < ApplicationController
  # 需要认证
  before_action :authenticate_user!

  # 筛选出所有的律师
  def index
    @lawyers = Users.where(is_lawyer: true)
  end

  # 律师页面
  def show
    binding.pry
    
    @lawyer = User.find(params[:id])
  end





end
