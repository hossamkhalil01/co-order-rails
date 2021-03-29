# To deliver this notification:
#
# InvResponseNotif.with(post: @post).deliver_later(current_user)
# InvResponseNotif.with(post: @post).deliver(current_user)

class InvResponseNotif < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :participant, :order
  # Define helper methods to make rendering easier.
  
  def message
    t(".message", name: params[:participant].first_name)
  end
  
  def url
    order_path(params[:order])
  end
end
