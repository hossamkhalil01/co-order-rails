class UserGroup < ApplicationRecord

    # Relationship with the owner user
    belongs_to :owner, class_name: "User", foreign_key: :user_id

end
