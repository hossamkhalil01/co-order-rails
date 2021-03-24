class OrdersController < ApplicationController
    
    def index
        @orders = current_user.orders.all
    end 

    def show 
        @order = current_user.orders.find(params[:id])
        @order_details = @order.details.all
        @detail = Detail.new
    end 

    def update_status

        @order = Order.find(params[:order_id])

        # Check for Authorization
        if (current_user.id  == @order.owner_id)
        
            @order.status = params[:status]
            @order.save
        
        end

        redirect_to orders_path
    end 
    
end
