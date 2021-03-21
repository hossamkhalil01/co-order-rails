class OrdersController < ApplicationController
    
    def index
        @orders = current_user.orders.all();
    end 

    def show 
        @order = current_user.orders.find(params[:id]);
        @order_details = @order.details.all;
    end 

    def edit
    end

    def new
    end

end
