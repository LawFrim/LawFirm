class Admin::OrdersController < AdminController

  def index
    @orders = Order.all.recent
  end
  
end
