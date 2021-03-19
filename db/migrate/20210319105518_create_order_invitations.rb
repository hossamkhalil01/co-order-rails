class CreateOrderInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :order_invitations do |t|
      t.references :participant,        null: false, foreign_key: {to_table: :users}
      t.references :order,              null: false, foreign_key: true
      t.boolean :accepted,              null: false, default: false

      t.timestamps
    end
  end
end
