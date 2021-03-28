class HomeController < ApplicationController
  def index
    @latest_orders = current_user.orders.order(created_at: :desc).limit(10)
    @friends = current_user.friends
  end
end
