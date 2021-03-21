class HomeController < ApplicationController
  def index
    @current_signed_user_image = UserImage.find(user_id=current_user.id)
  end
end
