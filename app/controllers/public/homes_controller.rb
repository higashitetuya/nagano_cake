class Public::HomesController < ApplicationController

  before_action :authenticate_customer!,except: [:top,:about]

  def top
    @items = Item.order("created_at DESC").limit(4) #最新のレコードを取得
  end

  def about
  end

end
