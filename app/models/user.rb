class User < ApplicationRecord
  ROLES = %w[user admin].freeze

  # Associations
  has_many :feeds,              dependent: :destroy
  has_many :source_suggestions, dependent: :nullify
  has_many :notifications,      dependent: :destroy

  has_many :reviewed_suggestions,
           class_name: "SourceSuggestion",
           foreign_key: :reviewed_by_id,
           dependent: :nullify,
           inverse_of: :reviewed_by

  # Callbacks
  before_validation :downcase_email

  # Validations
  validates :provider, presence: true
  validates :uid,      presence: true,
                       uniqueness: { scope: :provider }
  validates :email,    presence: true,
                       format: { with: URI::MailTo::EMAIL_REGEXP },
                       uniqueness: true
  validates :name,     presence: true
  validates :role,     presence: true,
                       inclusion: { in: ROLES }

  # Convenience methods
  def admin?
    role == "admin"
  end

  private

  def downcase_email
    self.email = email&.downcase
  end
end
