class Account::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]#必须注册用户才能建立订单。
  #按月支付服务费的订单
  def create_m
    @order = Order.new
    @order.user = current_user
    @order.item = "包月法律咨询服务费"
    @order.total = "999"
    @order.billing_name = current_user.order.billing_name
    @order.billing_address = current_user.order.billing_address

    if @order.save
      redirect_to account_order_path(@order)
    else
      redirect_to "/"
    end
  end
  #按年支付服务费的订单
  def create_y
    @order = Order.new
    @order.user = current_user
    @order.item = "包年法律咨询服务费"
    @order.total = "9999"


    if @order.save
      redirect_to account_order_path(@order)
    else
      redirect_to "/"
    end
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])

  end



  def index
    @order = Order.all
  end


  private

  def order_params
    params.require(:order).permit(:item,:total,:billing_name, :billing_address)
  end
end
