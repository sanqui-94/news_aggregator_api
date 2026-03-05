require "rails_helper"

RSpec.describe DefaultFeedSource, type: :model do
  describe "associations" do
    it { should belong_to(:source) }
  end

  describe "validations" do
    subject { create(:default_feed_source) }

    it { should validate_uniqueness_of(:source_id) }
  end
end
