class HomeController < ApplicationController
  def index
    @latest_orders = current_user.orders.order(created_at: :desc).limit(5)
    @friends = current_user.friends
  end
end
