class UsersController < ApplicationController
    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if user_params[:user]
        @user.update(:image=> user_params[:user][:image])
        redirect_to home_index_path
      else
        render 'edit'
      end
    end

    def user_params
      params.permit(:user=> [ :image ])
    end
end