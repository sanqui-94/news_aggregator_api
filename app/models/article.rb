class Article < ApplicationRecord
  # Associations
  belongs_to :source

  # Validations
  validates :title, presence: true
  validates :url, presence: true
  validates :published_at, presence: true
  validates :external_id, presence: true, uniqueness: { scope: :source_id }
end
