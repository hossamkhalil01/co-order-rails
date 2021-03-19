class AddUserFkToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference  :orders, :owner, foreign_key: {to_table: :users},  index: true
  end
end
