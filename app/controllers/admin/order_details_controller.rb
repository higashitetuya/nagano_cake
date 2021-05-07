class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    #@order_detail = params[:order_detail][:making_status]
      @order_detail = OrderDetail.find(params[:id])
      @order = @order_detail.order
    if params[:order_detail][:making_status] == "制作中" then
      @order = @order_detail.order
      @order.update( status: "制作中")
      @order_detail.update(order_detail_params)
      redirect_to admin_orders_show_path(@order.id), status: 301
    elsif @order.order_details.count == @order.order_details.where(making_status: "制作完了").count then
      @order.update( status: "発送済")
      @order_detail.update(order_detail_params)
      redirect_to admin_orders_show_path(@order.id), status: 301
    else
      @order_detail.update(order_detail_params)
      redirect_to admin_orders_show_path(@order.id), status: 301
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
