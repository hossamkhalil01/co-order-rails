# To deliver this notification:
#
# OrderStatusNotification.with(post: @post).deliver_later(current_user)
# OrderStatusNotification.with(post: @post).deliver(current_user)

class OrderStatusNotif < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :order

  # Define helper methods to make rendering easier.
  
  def message
    t(".message", owner_name: params[:order].owner.first_name,
       status: params[:order].status
    )
  end
  
  def url
    order_path(params[:order])
  end
end
