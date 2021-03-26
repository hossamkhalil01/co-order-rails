class OrdersController < ApplicationController
    

    def index
        # @orders = current_user.orders.all
        @orders = current_user.orders.all.paginate(page: params[:page])
    end 

    def show 
        @order = current_user.orders.find(params[:id])
        @order_details = @order.details.all.paginate(page: params[:page])
        @detail = Detail.new
        @invited_users = @order.invitations.all
        @accepted_users = @order.invitations.where("accepted = true")
        # 
        

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

    def new
        @order = current_user.orders.new
    end
    
    def create
        @order = current_user.orders.new(order_params)
        # puts @order.inspect
        @participant = User.where(invitation_params)[0]

        if @order.save
            # render @participant.inspection
            # @participant_id = @participant.id
            # @order_id = @order.id
            Invitation.create(participant_id: @participant.id, order_id: @order.id )
            redirect_to orders_path
        else
            render 'new'
        end
    end

    private

    
      

   

    def order_params
      params.require(:order).permit(:meal_type, :menu_image, :restaurant)
    end

    def invitation_params
        params.require(:order).permit(:email)
    end

end
