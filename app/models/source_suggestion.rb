class SourceSuggestion < ApplicationRecord
  STATUSES = %w[pending approved rejected].freeze

  include AASM

  belongs_to :user, optional: true
  belongs_to :reviewed_by, class_name: "User", optional: true

  validates :url,         presence: true,
                          format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                                    message: "must be a valid HTTP or HTTPS URL" }
  validates :description, presence: true,
                          length: { minimum: 50 }
  validates :status,      presence: true,
                          inclusion: { in: STATUSES }

  aasm column: :status do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
