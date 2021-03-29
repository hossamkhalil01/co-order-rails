class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :member, null: false, foreign_key: {to_table: :users}
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
