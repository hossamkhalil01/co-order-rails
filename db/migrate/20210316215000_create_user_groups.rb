class CreateUserGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :user_groups do |t|
      t.string :name,                 null: false
      t.timestamps
    end
  end
end
