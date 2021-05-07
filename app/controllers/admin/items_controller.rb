class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!

  def index
    if @genre = Genre.find_by(name: params[:search])
       @items = @genre.items.page(params[:page]).per(10)
    elsif params[:search] == '販売中'
       @items = Item.where(is_active: true).page(params[:page]).per(10)
    elsif params[:search] == '販売停止中'
       @items = Item.where(is_active: false).page(params[:page]).per(10)
    elsif
       @items = Item.all.page(params[:page]).per(10).search(params[:search])
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.genre_id = params[:genre][:name]
    if @item.save
       redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       redirect_to admin_items_path
    else
       render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  def item_params
  params.require(:item).permit(:name, :image, :introduction, :price, :is_active, :genre_id)
  end
end