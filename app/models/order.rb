class Order < ApplicationRecord

    # Relationship with order_details
    has_many :items, class_name: 'OrderItem',:dependent: :destroy

    # Relationship with user
    belongs_to :owner , class_name: "User", foreign_key: :owner_id

    # Relationship with invited_users
   #has_many :participants , :class_name: 'User' , :through => :order_invited_users 
end
