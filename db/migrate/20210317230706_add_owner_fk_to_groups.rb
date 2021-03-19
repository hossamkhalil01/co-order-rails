class AddOwnerFkToGroups < ActiveRecord::Migration[6.1]
  def change
    add_reference  :groups, :owner, foreign_key: {to_table: :users},  index: true
  end
end
