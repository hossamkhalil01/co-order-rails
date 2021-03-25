class OrdersController < ApplicationController
    
    def index
        @orders = current_user.orders.all
    end 

    def show 
        @order = current_user.orders.find(params[:id])
        @order_details = @order.details.all
    end 

    def new
        @order = Order.new
    end

    def create 
        @order = Order.new({"meal"=>orders_path[:meal] , "restaurant_name"=>orders_path[:restaurant_name] ,"menu_image"=>orders_path[:menu_image] })
        @order.user_id = current_user.id
        @order.save
        @owner=current_user.first_name
        if @order.save
           
            redirect_to "/orders/#{@order.id}/details"
        else
            render 'new'
        end
       
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
