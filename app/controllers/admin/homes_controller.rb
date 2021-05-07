class Admin::HomesController < ApplicationController

  before_action :authenticate_admin! #ログインしていないと遷移できない

  def top
    @orders = Order.all.page(params[:page]).per(10)
  end
end