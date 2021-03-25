class FriendsController < ApplicationController
  
    
  # before_action :set_friend, only: [:show, :update, :destroy]

  # GET /friends
  # def index

  #   @user_friends = current_user.friends   
  #   puts @user_friends  

  #   render 'index'
  # end
  #   #new_friend
  #   def new
  #     @user  = User.find_by_email(params[:email])
  #     puts params[:email]
  #     puts user.id

  #   end

  #   def create
  #       @friend = current_user.friendships.new(order_params)
  #       if @friend.save
  #           redirect_to friends_path
  #       else
  #           render 'index'
  #       end
  #   end
    
    def index
      @users = User.all
      @friends = Friendship.all
      @friend = Friendship.new
      # @allNotifications=fun(current_user)[0..4] ;
  
    end
  
    def add; end
  
    def destroy
      @friend = Friendship.find(params[:id])
      @friend.destroy
  
      redirect_to friends_path
    end
  
    def create
  
      users = params[:users].split(',')
      if !users.empty?
        users.each do |user|
          if user != current_user.id
            @friend = Friendship.new(user_id: current_user.id, friend_id: user)
           
            if(! @friend.save)
              $FriendError=[]
              $FriendError.push( @friend.errors.full_messages[0].to_s);
            end
          end
        end
      else
        $FriendError.push("Email Field is empty")
      end
      redirect_to friends_path #user_friends_path(current_user.id)
  
    end

  # # POST /friends
  # def create
  #   @user  = User.find_by_email(params[:email])
  #   puts @user.nil?
  #   if @user.nil? == true
  #     puts 333
  #     render json: {message:"not found"}
  #     return 
  #   end

  #     @friend = Friend.new(friend_id: @user[:id])
  #     @friend.user_id = $user_id

  #     #check if user exits before add him to friend list      
  #     if @friend.save
  #       render json: {message:"success"}
  #     else
  #       render json:{message:"fail"}
   
  #     end
  # end

  # # PATCH/PUT /friends/1
  # def update
  #   if @friend.update(friend_params)
  #     render json: @friend
  #   else
  #     render json: @friend.errors, status: :unprocessable_entity
  #   end
  # end

  # def delete
  #   puts $user_id
  #   puts params[:id]
  #     puts json: Friend.where(friend_id: params[:id],user_id: $user_id)
  #   if  Friend.where(friend_id: params[:id],user_id: $user_id).delete_all
  #    render json:  {message:"success"}
  #   else
  #     render json: {message:"failed"}
  #   end
  # end

  # # latest activities of a certain user

  # def latestActivities
  #   @friends = Friend.all.where(user_id: $user_id)
  #   @friends_activities = [];
  #   @friends.each do |friend|
  #     @friend_activities = {};
  #     name = (User.select("name").where(id: friend.friend_id))
  #     @friend_activities[:freind_name]=name
  #     @friend_orders=Order.select("meal_name","restaurant_name","status","created_at").where(user_id: friend.friend_id).limit(2).order("created_at Desc")
  #     @friend_activities[:friend_orders]=@friend_orders
  #     @friends_activities.push @friend_orders
  #   end
  #   if @friends_activities
  #     # render :json => {:friends_activities => @friends_activities}
  #     render json: @friends_activities
  #   else
  #     render json: @friends_activities.errors, status: :unprocessable_entity
  #   end
  # end    
    

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_friend
  #     @friend = Friend.find(params[:id])
  #   end

    # Only allow a trusted parameter "white list" through.
    # def friend_params
    #   params.require(:friend).permit(:email)
    # end
    private

    def friend_params
      params.require(:friendship).permit(:friend_id)
    end


end