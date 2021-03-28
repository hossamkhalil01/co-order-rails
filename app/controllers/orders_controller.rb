class OrdersController < ApplicationController
    
    @@invited_members_arr = []

    def index
        # @orders = current_user.orders.all
        @orders = current_user.orders.all.paginate(page: params[:page])
    end 

    def show 
        #*************** check accpted or owner == current 
        @order = Order.find(params[:id])
        @order_details = @order.details.all.paginate(page: params[:page])
        @detail = Detail.new
        @pending_invitations = @order.invitations.where("accepted = false")
        @accepted_invitations = @order.invitations.where("accepted = true")
        # authorized
        @authorized = false 
        current_user.id == @order.owner_id ?  @authorized = true :  @authorized = false 
        @accepted_invitations.each do |invitation|
            if invitation.participant_id == current_user.id  
                @authorized = true
            end
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

    def new
        @order = current_user.orders.new
        @@invited_members_arr = []
    end
    
    def create
        @order = current_user.orders.new(order_params)
        # invited_friends = []
        if @order.save
            # inviteGroup_params[:test_groups].each do |group_id|
            #     if (! (group_id.empty?) )
            #         Group.find(group_id.to_i).members.each do |friend|
            #             invited_friends.push(friend.id)
            #         end
            #     end
            # end
            # tmp_friend = test_params[:test_users].reject { |c| c.empty? } 
            # invited_friends += tmp_friend.map(&:to_i)
            # invited_friends.uniq! 
        
            @@invited_members_arr.each do |friend_id|             
                invited_user = Invitation.new
                invited_user.order_id = @order.id
                invited_user.participant_id = friend_id
                invited_user.save
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
                # puts " hiiiiiiiii"
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
        puts "fix your db "
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
