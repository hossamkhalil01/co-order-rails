class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.string :item
      t.text :comment
      t.float :price
      t.int :amount

      t.timestamps
    end
  end
end
