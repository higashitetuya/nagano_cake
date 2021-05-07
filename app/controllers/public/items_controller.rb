class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!,except: [:index,:show]

  def index
       @count = Item.where(is_active: 'true').count
    if @genre = Genre.find_by(name: params[:search])
       @items = @genre.items.where(is_active: 'true').page(params[:page]).per(8)
       @count = @genre.items.where(is_active: 'true').count
       @search = params[:search]
    else
       @items = Item.where(is_active: 'true').page(params[:page]).per(8).search(params[:search])
       @search = params[:search]
    end
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end
end