class HomeController < ApplicationController
  def index
    @latest_orders = current_user.orders
  end
end
