class NotificationsController < ApplicationController

    def index
        @notifications = current_user.notifications.unread
    end

    def mark_as_read

        @notifications = current_user.notifications.unread 

        @notifications.each do |notification|
            notification.mark_as_read!
        end

        render json: {success: true}
    end 
end