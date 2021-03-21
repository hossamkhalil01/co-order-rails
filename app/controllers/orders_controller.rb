class OrdersController < ApplicationController
    
    def index
        @orders = current_user.orders.all();
    end 

    def show 
        @order = current_user.orders.find(params[:id]);
        @order_items = @order.items.all;
    end 

    def edit
    end

end
