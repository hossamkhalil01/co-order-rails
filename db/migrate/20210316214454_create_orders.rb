class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :meal_type
      t.string :restaurant
      t.string :status

      t.timestamps
    end
  end
end
