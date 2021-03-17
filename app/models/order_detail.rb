class OrderDetail < ApplicationRecord
    # Relationship with order
    belongs_to :order
end
