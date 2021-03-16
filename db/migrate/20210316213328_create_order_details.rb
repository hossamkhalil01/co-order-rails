class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.string :item,               null: false
      t.text :comment,              null: false
      t.float :price,               null: false
      t.integer :amount,            null: false, default: 1

      t.timestamps
    end
  end
end
