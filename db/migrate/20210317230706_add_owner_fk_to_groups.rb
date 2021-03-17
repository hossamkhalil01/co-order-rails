class AddOwnerFkToGroups < ActiveRecord::Migration[6.1]
  def change
    add_reference  :user_groups, :user, foreign_key: true
  end
end
