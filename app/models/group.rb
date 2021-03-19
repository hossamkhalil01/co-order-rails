class Group < ApplicationRecord

    # Relationship with the owner user
    belongs_to :owner, class_name: "User", foreign_key: :owner_id

    # Relationship with group members
    has_many :group_members 
    has_many :members, class_name: "User", through: :group_members

end
