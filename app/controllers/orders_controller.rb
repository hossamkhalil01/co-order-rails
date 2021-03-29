class OrdersController < ApplicationController
    
    @@invited_members_arr = []

    def index
        # @orders = current_user.orders.all
        @orders = current_user.orders.all.paginate(page: params[:page])
    end 

    def show 
        # *************** check accpted or owner == current 
        @order = Order.find(params[:id])
        @order_details = @order.details.all.paginate(page: params[:page])
        @detail = Detail.new
        @pending_invitations = @order.invitations.pending_invitations
        @accepted_invitations = @order.invitations.accepted_invitations
        # authorized
        @authorized = false 
        current_user.id == @order.owner_id ?  @authorized = true :  @authorized = false 
        @accepted_invitations.each do |invitation|
            if invitation.participant_id == current_user.id  
                @authorized = true
            end
        end
        if ! ( @authorized )
           redirect_to order_order_summary_path(params[:id])
        end
    end 
    
    # order_accept_invitation GET   /orders/:order_id/accept_invitation(.:format)    orders#accept_invitation
    def accept_invitation
        @invitation = Invitation.where(participant_id: current_user.id , order_id: params[:order_id])[0]
        @invitation.accepted = true 
        @invitation.save
        @current_order = Order.find(params[:order_id])
        @order_owner = User.find(@current_order.owner_id)
        InvResponseNotif.with(order: @current_order, participant: current_user).deliver_later(@order_owner)
        redirect_to  order_path(params[:order_id])
    end


    # order_order_summary GET      /orders/:order_id/summary(.:format)    orders#summary
    def summary
        @order_summary = Order.find(params[:order_id])
        @all_order_participants = @order_summary.participants 
    end

    def new
        @order = current_user.orders.new
        @@invited_members_arr = []
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


    def create
        @order = current_user.orders.new(order_params)
        if @order.save
            
            @@invited_members_arr.each do |friend_id|             
                invited_user = Invitation.new
                invited_user.order_id = @order.id
                invited_user.participant_id = friend_id
                invited_user.save
                InvitationNotif.with(order: @order).deliver_later(User.find(friend_id))
            end

            @@invited_members_arr = []
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

    # search_invited GET      /order_invited_members(.:format)  orders#search_invited
    def search_invited
        if params[:invited].present?
            # @group = current_user.groups.find(params[:group_id])
            @invited_members = current_user.friends.search(params[:invited])
            @invited_members = current_user.except_current_user(@invited_members)
            @invited_groups = current_user.groups.search(params[:invited])
            if @invited_members || @invited_groups
                respond_to do |format|               
                    # format.html { render partial: 'orders/order_invited_member' }
                    format.js { render partial: 'orders/order_invited_member' }
                end
            else
                respond_to do |format|
                    # flash.now[:alert] = "Couldn't find user"
                    format.js { render partial: 'orders/order_invited_member' }
                end
            end    
        else
            respond_to do |format|
                # flash.now[:alert] = "Please enter a friend name or email to search"
                @invited_members = []
                @invited_groups = []
                format.js { render partial: 'orders/order_invited_member' }
            end
        end
    
    end

    # add_invited GET      /order_add_members(.:format)  orders#add_invited  
    def add_invited
        if params[:member_id]
            # puts params[:member_id]
            if !(params[:member_id].empty?)
                @@invited_members_arr.push(params[:member_id].to_i)
            end
        else 
            # puts params[:group_id]
            # params[:group_id].to_a.each do |group_id|
                if (! (params[:group_id].empty?) )
                    Group.find(params[:group_id].to_i).members.each do |friend|
                        @@invited_members_arr.push(friend.id)
                    end
                end
            # end
        end
        @@invited_members_arr.uniq!
        # puts @@invited_members_arr
        # user = User.all
        @invited_members_arr_local = []
        @@invited_members_arr.each do |friend_id|             
            @invited_members_arr_local.push(User.find(friend_id))
        end
        if @invited_members_arr_local
            respond_to do |format|               
                format.js { render partial: 'orders/order_added_member_arr' }
            end
         end
    end

    # remove_invited GET    /order_remove_member/:remove_member_id(.:format)       orders#remove_invited
    def remove_invited
        @invited_members_arr_local = []
        if params[:remove_member_id]
            @@invited_members_arr.delete(params[:remove_member_id].to_i)
            @@invited_members_arr.each do |friend_id|             
                @invited_members_arr_local.push(User.find(friend_id))
            end
            if @invited_members_arr_local
                respond_to do |format|               
                    format.js { render partial: 'orders/order_added_member_arr' }
                end
             end
        end  
    end

    private

    def order_params
        params.require(:order).permit(:meal_type, :menu_image, :restaurant)
    end

    def inviteGroup_params
        params.require(:order).permit(:test_groups=>[])
    end

    def test_params
        params.require(:order).permit(:test_users=>[])
    end

end
