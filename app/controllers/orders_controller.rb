class OrdersController < ApplicationController
    

    def index
        # @orders = current_user.orders.all
        @orders = current_user.orders.all.paginate(page: params[:page])
    end 

    def show 
        @order = Order.find(params[:id])
        @order_details = @order.details.all.paginate(page: params[:page])
        @detail = Detail.new
        @participants = @order.participants.all
        @accepted_invitations = @order.invitations.where("accepted = true")

    end 

    def new
        @order = Order.new
    end

    def update_status

        @order = Order.find(params[:order_id])

        # Check for Authorization
        if (current_user.id  == @order.owner_id)
        
            @order.status = params[:status]
            @order.save
            OrderStatusNotif.with(order: @order).deliver_later(@order.participants)
        end

        redirect_to orders_path
    end 

    def new
        @order = current_user.orders.new
    end
    
    def create
        @order = current_user.orders.new(order_params)
        @participant = User.where(invitation_params)[0]

        if @order.save
            Invitation.create(participant_id: @participant.id, order_id: @order.id )
            InvitationNotif.with(order: @order).deliver_later(@order.participants)
            
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
