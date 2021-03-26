class Order < ApplicationRecord

    # Relationship with order_details
    has_many :details, class_name: 'Detail',dependent: :destroy

    # Relationship with user
    belongs_to :owner , class_name: "User", foreign_key: :owner_id

    # Relationship with order invitations
    has_many :invitations
    has_many :participants , class_name: 'User' , :through => :invitations

    # Validation
    validates :status, presence: true, acceptance: { accept: ['active', 'finish' , 'cancel'] }
    validates :meal_type, presence: true, acceptance: { accept: ['breakfast', 'lunch' , 'dinner'] }

    # broadcast to home page after craeting order
    after_create_commit -> { broadcast_prepend_to "orders" }
    after_create_commit -> { broadcast_prepend_to "latest-orders" }
end 
