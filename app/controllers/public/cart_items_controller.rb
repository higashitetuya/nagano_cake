class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
   @customer = current_customer
   @cart_items = current_customer.cart_items
   @sum = 0
  end

  def create

   if params[:cart_item][:amount].empty?
       flash[:notice] = "個数を選択してください！"
       redirect_back(fallback_location: items_path)
   else

   @cart_item = CartItem.new(cart_item_params)
   @cart_item.customer_id = current_customer.id
   @cart_item = current_customer.cart_items.build(cart_item_params)
   @cart_items = current_customer.cart_items.all
   @cart_items.each do |cart_item|
    if cart_item.item_id == @cart_item.item_id
      new_amount = cart_item.amount + @cart_item.amount
      cart_item.update_attribute(:amount, new_amount)
      @cart_item.delete
    end
  end
   @cart_item.save
   redirect_to cart_items_path
   end
  end

  def destroy
   @cart_item = CartItem.find(params[:id])
   @cart_item.destroy
   redirect_to cart_items_path
  end

  def update
   @cart_item = CartItem.find(params[:id])
   @cart_item.update(cart_item_params)
   redirect_to cart_items_path
  end

  def destroy_all
   if current_customer.cart_items.empty? then
     flash[:notice] = "商品をカートに追加してください。"
     redirect_to cart_items_path
   else
     @cart_items = current_customer.cart_items.destroy_all
     redirect_to cart_items_path
   end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end
