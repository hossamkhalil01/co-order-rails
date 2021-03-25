
class FriendsController < ApplicationController
    before_action :authenticate_user!

    def create
      user = User.find_by email: params[:email]
      if user
        if (Friendship.where(:friend_id => user.id, :user_id => current_user.id).count > 0) 
          flash[:error] = "Unable to add friend."
            redirect_to friends_path
        else
          if Friendship.create(friend_id: user.id, user_id: current_user.id)
            flash[:notice] = "Friend added."
            redirect_to friends_path
          else
            flash[:error] = "Unable to add friend."
            redirect_to friends_path
          end
        end
      else
        flash[:error] = "user not found"  
      end
    end
      
    def destroy
        @friend = Friendship.where(friend_id: params[:id])[0]
        @friend.destroy
        flash[:notice] = "Friend Removed."
        redirect_to friends_path
    end

    def index
        @friends = current_user.friends
    end


 
end