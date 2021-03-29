class NotificationsController < ApplicationController

    def index
        @limited_notifications = current_user.notifications.order(created_at: :desc).limit(5)
        @notifications = current_user.notifications
    end

    def show 
        @notifications = current_user.notifications
    end 

    def mark_as_read

        @notifications = current_user.notifications.unread 

        @notifications.each do |notification|
            notification.mark_as_read!
        end

        render json: {success: true}
    end 
end