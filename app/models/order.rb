class Order < ApplicationRecord

    # Relationship with order_details
    has_many :items, class_name: 'OrderItem',:dependent: :destroy

    # Relationship with user
    belongs_to :owner , class_name: "User", foreign_key: :owner_id

    # Relationship with order_invitations
    has_many :participants , :class_name: 'User' , :through => :order_invitations
end
