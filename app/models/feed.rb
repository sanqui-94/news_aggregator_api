class Feed < ApplicationRecord
  belongs_to :user
  has_many :feed_sources, dependent: :destroy
  has_many :sources, through: :feed_sources

  validates :name, presence: true
end
