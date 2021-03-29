class HomeController < ApplicationController
  def index
    @latest_orders = current_user.orders.order(created_at: :desc).limit(8)
    @friends_orders = Order.where({ owner_id: current_user.friends }).order(created_at: :desc).limit(8)
  end
end
