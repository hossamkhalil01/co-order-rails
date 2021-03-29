class AddOrdererFkToDetails < ActiveRecord::Migration[6.1]
  
  def change
    add_reference :details, :orderer, foreign_key: {to_table: :users},  index: true
  end
end
