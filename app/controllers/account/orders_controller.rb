class Account::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]#必须注册用户才能建立订单。
  #结账页
  def checkout
    @order = Order.new
    @order.user = current_user
    @order.item = "包年法律咨询"
    @order.total = "9999"
      if @order.save
        [:account,@order].each do |order|
        orders_list = Orders_list.new
        orders_list.order = @order
        orders_list.item = @order.item
        orders_list.total = @order.total
        orders_list.billing_name = @order.billing_name
        orders_list.billing_address = @order.billing_address
        orders_list.user_name = @order.user_name
        orders_list.save
          end
      redirect_to create_y_account_order_path(@order)
    else
      render "account/checkout"
    end

  end
  #按月支付服务费的订单
  def create_m
    @order = Order.new
    @order.user = current_user
    @order.item = "包月法律咨询"
    @order.total = "999"

    if @order.save
      redirect_to account_order_path(@order)
    else
        render 'order/create_m'
    end
  end
  #按年支付服务费的订单
  def create_y
    @order = Order.new
    @order.user = current_user
    @order.item = "包年法律咨询"
    @order.total = "9999"

    if @order.save
      redirect_to account_order_path(@order)
    else
      render :new
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
    redirect_to account_order_path(@order)
  end

  def pay_with_wechat
    @order = Order.find(params[:id])
    @order.set_payment_with!("wechat")
    @order.pay!
    redirect_to account_order_path(@order)
  end


  def index
    @orders = Order.all.where(user_id: current_user).recent
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new
    if @order.save
      redirect_to account_orders_path
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
