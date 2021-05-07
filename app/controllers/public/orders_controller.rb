class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    if current_customer.cart_items.empty? then
       flash[:notice] = "商品をカートに追加してください。"
       redirect_to cart_items_path
    else
    @order = Order.new
    @addresses = current_customer.addresses #1対多の時に使用
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_details = @order.order_details.new
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.price
      @order_details.amount = cart_item.amount
      @order_details.save
    current_customer.cart_items.destroy_all
  end
    redirect_to orders_complete_path
  end

  def confirm
    if params[:order][:address_method].nil? then
       flash[:notice] = "お届け先を選択してください"
       redirect_to orders_new_path
    else
      @cart_items = current_customer.cart_items
      @sum = 0
      @shipping_cost = 800
      @customer = current_customer
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      if params[:order][:address_method]["1"] then
        @order.name = current_customer.last_name + current_customer.first_name
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
      elsif params[:order][:address_method]["2"] then
        @address = Address.find(params[:order][:address_id])
        @order.name = @address.name
        @order.postal_code = @address.postal_code
        @order.address = @address.address
      elsif params[:order][:address_method]["3"] then
        if params[:order][:postal_code].empty? || params[:order][:address].empty? || params[:order][:name].empty?
           @order.save
           render :new
        else
        end
      end
    end

  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method,:status)
  end

end

