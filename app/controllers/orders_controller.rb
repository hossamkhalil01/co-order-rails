class OrdersController < ApplicationController
    

    def index
        # @orders = current_user.orders.all
        @orders = current_user.orders.all.paginate(page: params[:page])
    end 

    def show 
        @order = current_user.orders.find(params[:id])
        @order_details = @order.details.all.paginate(page: params[:page])
        @detail = Detail.new
        @participants = @order.participants.all
        @accepted_invitations = @order.invitations.where("accepted = true")

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
        invited_friends = []
        if @order.save
            inviteGroup_params[:test_groups].each do |group_id|
                if (! (group_id.empty?) )
                    Group.find(group_id.to_i).members.each do |friend|
                        invited_friends.push(friend.id)
                    end
                end
            end
            tmp_friend = test_params[:test_users].reject { |c| c.empty? } 
            invited_friends += tmp_friend.map(&:to_i)
            invited_friends.uniq! 
        
            invited_friends.each do |friend_id|             
                invited_user = Invitation.new
                invited_user.order_id = @order.id
                invited_user.participant_id = friend_id
                invited_user.save
            end
            redirect_to orders_path
        else
            render 'new'
        end
    end



    # order_destroy_invitation DELETE   /orders/:order_id/invitation/:invitation_id(.:format) 
    def destroy_invitation
        @order = Order.find(params[:order_id])
        @invitation = Invitation.find(params[:invitation_id])
        if  @order.owner_id == current_user.id
            @invitation.destroy  
        end
        redirect_to order_path(params[:order_id])    
    end

    private


    def order_params
      params.require(:order).permit(:meal_type, :menu_image, :restaurant)
    end

    # def invitUser_params
    #     params.require(:order).permit(:email)
    # end

    def inviteGroup_params
        params.require(:order).permit(:test_groups=>[])
    end

    def test_params
        params.require(:order).permit(:test_users=>[])
    end

    # def final_params
    #     params.require(:order).permit(:final_users=>[]).mer
    # end
    # def users_params
    #     puts params.inspect
    #     puts  params.require(:order).permit(:users).inspect
    #     params.require(:order).permit(:users)
        

    # end

end


   
