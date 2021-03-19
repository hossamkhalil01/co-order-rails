class AddOrdererFkToOrderItems < ActiveRecord::Migration[6.1]
  
  def change
    add_reference :order_items, :orderer, foreign_key: {to_table: :users},  index: true
  end
end
