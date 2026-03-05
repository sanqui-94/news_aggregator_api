require "rails_helper"

RSpec.describe SourceSuggestion, type: :model do
  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:reviewed_by).optional }
  end

  describe "validations" do
    subject { build(:source_suggestion) }

    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(SourceSuggestion::STATUSES) }

    it { should allow_value("https://example.com/feed.xml").for(:url) }
    it { should_not allow_value("not-a-url").for(:url) }
    it { should_not allow_value("ftp://example.com").for(:url) }

    it { should validate_length_of(:description).is_at_least(50) }
  end

  describe "AASM state machine" do
    let(:suggestion) { create(:source_suggestion) }

    it "starts in pending state" do
      expect(suggestion).to be_pending
    end

    it "transitions from pending to approved" do
      suggestion.approve!
      expect(suggestion).to be_approved
    end

    it "transitions from pending to rejected" do
      suggestion.reject!
      expect(suggestion).to be_rejected
    end

    it "cannot approve an already rejected suggestion" do
      suggestion.reject!
      expect { suggestion.approve! }.to raise_error(AASM::InvalidTransition)
    end

    it "cannot reject an already approved suggestion" do
      suggestion.approve!
      expect { suggestion.reject! }.to raise_error(AASM::InvalidTransition)
    end
  end
end
