class Order < ApplicationRecord

    # Relationship with order_details
    has_many :order_details, dependent: :destroy
    # Relationship with user
    belongs_to :user
end
