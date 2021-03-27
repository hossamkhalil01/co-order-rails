class HomeController < ApplicationController
  def index
    @groups = Group.all
    @notifications = current_user.notifications
  end
end
