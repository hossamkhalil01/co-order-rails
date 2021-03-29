class AddOrderFkToDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :details, :order, foreign_key: true
  end
end
