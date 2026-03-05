class Notification < ApplicationRecord
  belongs_to :user

  validates :type, presence: true
  validates :data, presence: true

  scope :unread, -> { where(read: false) }
  scope :read,   -> { where(read: true) }
end
