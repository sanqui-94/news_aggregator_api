class Source < ApplicationRecord
  # Associations
  has_many :source_tags,          dependent: :destroy
  has_many :tags,                 through: :source_tags
  has_many :articles,             dependent: :destroy
  has_many :feed_sources,         dependent: :destroy
  has_many :feeds,                through: :feed_sources
  has_one  :default_feed_source,  dependent: :destroy

  # Validations
  validates :name,   presence: true
  validates :url,    presence: true,
                     uniqueness: true,
                     format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                              message: "must be a valid HTTP or HTTPS URL" }

  # Scopes
  scope :active,   -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
