class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.string :meal_type,              null: false, default: "lunch"
      t.string :menu_image,             null: false, default: ""
      t.string :restaurant,             null: false
      t.string :status,                 null: false, default: "active"
      t.timestamps
    end
  end
end
