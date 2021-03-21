class Detail < ApplicationRecord
    
    # Relationship with order
    belongs_to :order

    # Relationship with the person odering
    belongs_to :orderer, class_name: "User", foreign_key: :orderer_id

end
