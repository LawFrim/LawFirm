class Account::OrdersController < AccountController


  #按月支付服务费的订单
  def create_m

    order_info

    @order.item = "包月法律咨询"
    @order.total = "999"

    save_order

  end
  #按年支付服务费的订单
  def create_y

    order_info

    @order.item = "包年法律咨询"
    @order.total = "9999"

    save_order

  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end


  def pay_with_alipay
    order_pay
    @order.set_payment_with!("alipay")
    redirect_to account_orders_path(@order)
  end

  def pay_with_wechat
    order_pay
    @order.set_payment_with!("wechat")
    redirect_to account_orders_path(@order)
  end


  def index
    @orders = Order.all.where(user_id:current_user).recent
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


#暂不使用
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to account_orders_path
    else
      render :edit
    end
  end



  private

  def order_pay
    @order = Order.find(params[:id])
    @order.pay!
    @order.user = current_user
    @order.user.pay!#管理员用户中心显示支付状态
  end




  def order_info
    @order = Order.new
    @order.user = current_user
    @order.billing_name = current_user.user_name
    @order.billing_address = current_user.email
  end

  def save_order
    if @order.save
      redirect_to account_order_path(@order)
    else
      redirect_to :back
    end
  end

  def order_params
    params.require(:order).permit(:item,:total,:billing_name, :billing_address)
  end
end
