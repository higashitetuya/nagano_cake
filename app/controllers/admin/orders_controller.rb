class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.new(order_params)
    @order = Order.find(params[:id])
    if params[:order][:status] == "入金確認" then
      @order = Order.find(params[:id])
      @order_details = @order.order_details
      @order_details.update( making_status: "制作待ち")
      @order.update(order_params)
      redirect_to admin_orders_show_path(@order.id), status: 301
    else
      @order.update(order_params)
      redirect_to admin_orders_show_path(@order.id), status: 301
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
