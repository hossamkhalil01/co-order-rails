# To deliver this notification:
#
# InvitationNotif.with(post: @post).deliver_later(current_user)
# InvitationNotif.with(order: @order).deliver(User.all)
class InvitationNotif < Noticed::Base
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
  #
  def message
    t(".message", owner_name: params[:order].owner.first_name,
      type: params[:order].meal_type)
  end
  
  def url
    order_path(params[:order])
  end
end
