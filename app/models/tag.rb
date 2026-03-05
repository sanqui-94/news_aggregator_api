class Tag < ApplicationRecord
  # Associations
  has_many :source_tags, dependent: :destroy
  has_many :sources,     through: :source_tags

  # Callbacks
  before_validation :generate_slug

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  private

  def generate_slug
    return if slug.present?
    self.slug = name&.downcase&.gsub(/[^a-z0-9]+/, "-")&.gsub(/\A-|-\z/, "")
  end
end
