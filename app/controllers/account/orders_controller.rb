class Account::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]#必须注册用户才能建立订单。
  #按月支付服务费的订单
  def create_m
    @order = Order.new
    @order.user = current_user
    @order.item = "包月法律咨询"
    @order.total = "999"
    @order.billing_name = current_user.user_name
    @order.billing_address = current_user.email
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
    @order.item = "包年法律咨询"
    @order.total = "9999"
    @order.billing_name = current_user.user_name
    @order.billing_address = current_user.email
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


  def pay_with_alipay
    @order = Order.find(params[:id])
    @order.set_payment_with!("alipay")
    @order.pay!
    @order.user = current_user
    @order.user.pay!
    redirect_to account_orders_path(@order)
  end

  def pay_with_wechat
    @order = Order.find(params[:id])
    @order.set_payment_with!("wechat")
    @order.pay!
    @order.user = current_user
    @order.user.pay!
    redirect_to account_orders_path(@order)
  end


  def index
    @orders = Order.all.where(user_id: current_user).recent
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_path
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to account_orders_path
    else
      render :edit
    end
  end



  private

  def order_params
    params.require(:order).permit(:item,:total,:billing_name, :billing_address)
  end
end
