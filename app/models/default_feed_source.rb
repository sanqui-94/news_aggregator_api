class DefaultFeedSource < ApplicationRecord
  belongs_to :source

  validates :source_id, uniqueness: true
end
