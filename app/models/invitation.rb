class Invitation < ApplicationRecord
  belongs_to :participant, class_name: "User", foreign_key: :participant_id
  belongs_to :order
  scope :accepted_invitations , -> { where('accepted = true') }
  scope :pending_invitations , -> { where('accepted = false') }
end
