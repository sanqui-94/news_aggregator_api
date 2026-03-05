require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "associations" do
    it { should have_many(:source_tags).dependent(:destroy) }
    it { should have_many(:sources).through(:source_tags) }
  end

  describe "validations" do
    subject { create(:tag) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe "#generate_slug" do
    it "generates a slug from the name" do
      tag = build(:tag, name: "Ruby on Rails")
      tag.valid?
      expect(tag.slug).to eq("ruby-on-rails")
    end

    it "does not overwrite an existing slug" do
      tag = build(:tag, name: "Technology", slug: "tech")
      tag.valid?
      expect(tag.slug).to eq("tech")
    end

    it "strips leading and trailing hyphens" do
      tag = build(:tag, name: "  Rails  ")
      tag.valid?
      expect(tag.slug).to eq("rails")
    end

    it "collapses multiple special characters into a single hyphen" do
      tag = build(:tag, name: "Ruby & Rails!")
      tag.valid?
      expect(tag.slug).to eq("ruby-rails")
    end
  end
end
