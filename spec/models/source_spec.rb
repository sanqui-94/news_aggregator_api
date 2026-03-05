require "rails_helper"

RSpec.describe Source, type: :model do
  describe "associations" do
    it { should have_many(:source_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:source_tags) }
    it { should have_many(:articles).dependent(:destroy) }
    it { should have_many(:feed_sources).dependent(:destroy) }
    it { should have_many(:feeds).through(:feed_sources) }
    it { should have_one(:default_feed_source).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:source) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }

    it { should allow_value("http://example.com/feed.xml").for(:url) }
    it { should allow_value("https://example.com/feed.xml").for(:url) }
    it { should_not allow_value("not-a-url").for(:url) }
    it { should_not allow_value("ftp://example.com").for(:url) }
  end

  describe "scopes" do
    let!(:active_source)   { create(:source, active: true) }
    let!(:inactive_source) { create(:source, active: false) }

    it "returns active sources" do
      expect(Source.active).to include(active_source)
      expect(Source.active).not_to include(inactive_source)
    end

    it "returns inactive sources" do
      expect(Source.inactive).to include(inactive_source)
      expect(Source.inactive).not_to include(active_source)
    end
  end
end
