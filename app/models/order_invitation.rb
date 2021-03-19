class OrderInvitation < ApplicationRecord
  belongs_to :user, , class_name: "User", foreign_key: :participant_id
  belongs_to :order
end
