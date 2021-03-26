class Group < ApplicationRecord

    # Relationship with the owner user
    belongs_to :owner, class_name: "User", foreign_key: :owner_id

    # Relationship with group members
    has_many :memberships, dependent: :destroy
    has_many :members, class_name: "User", through: :memberships
    validates :name , presence: true,  format: {with: /[a-zA-Z]/}

    def group_member?(id_of_member)
        self.members.where(id: id_of_member).exists?
    end

end
