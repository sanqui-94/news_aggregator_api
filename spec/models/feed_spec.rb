require "rails_helper"

RSpec.describe Feed, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:feed_sources).dependent(:destroy) }
    it { should have_many(:sources).through(:feed_sources) }
  end

  describe "validations" do
    subject { build(:feed) }

    it { should validate_presence_of(:name) }
  end
end
