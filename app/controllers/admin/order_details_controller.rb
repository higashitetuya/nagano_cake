class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    #@order_detail = params[:order_detail][:making_status]
      @order_detail = OrderDetail.find(params[:id])
      @order = @order_detail.order
      @order_detail.update(order_detail_params)
    if params[:order_detail][:making_status] == "制作中" then
      @order.update( status: "制作中")
      redirect_to admin_orders_show_path(@order.id)
    elsif @order.order_details.count == @order.order_details.where(making_status: "制作完了").count then
      @order.update( status: "発送済")
      redirect_to admin_orders_show_path(@order.id)
    else
      redirect_to admin_orders_show_path(@order.id)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
