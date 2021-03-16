class CreateOrderInvitedUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :order_invited_users do |t|
      t.boolean :joined,              null: false, default: false
      t.timestamps
    end
  end
end
