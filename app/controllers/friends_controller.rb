class FriendsController < ApplicationController
    before_action :authenticate_user!

    def create
      user = User.find_by email: params[:email]
      if user
        if (Friendship.where(:friend_id => user.id, :user_id => current_user.id).count > 0) 
          flash[:error] = "Friend already exists."
        else
          if (current_user.id == user.id) 
            flash[:error] = "You can't add yourself."
          else
              if Friendship.create(friend_id: user.id, user_id: current_user.id)
                flash[:notice] = "Friend added."
              else
                flash[:error] = "Unable to add friend."
              end
          end
        end
      else
        flash[:error] = "Email not found"
      end
      redirect_to friends_path
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



    def listF
      # @users = User.all
     
      @friends = current_user.friends
      # format.json { render json: @friends }
      render :json => @friends, :include => :friend
    end 
    
end
