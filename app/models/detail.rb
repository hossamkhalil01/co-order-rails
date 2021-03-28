class Detail < ApplicationRecord
    self.per_page = 2

    # Relationship with order
    belongs_to :order

    # Relationship with the person odering
    belongs_to :orderer, class_name: "User", foreign_key: :orderer_id

    # Validation
    validates :orderer_id, :order_id, :item, :price, presence: true
    validates :comment, length: {maximum: 100}
    validates :price , numericality: { only_integer: false }
    validates :amount, numericality: { only_integer: true }
end
