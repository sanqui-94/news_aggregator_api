require "rails_helper"

RSpec.describe Article, type: :model do
  describe "associations" do
    it { should belong_to(:source) }
  end

  describe "validations" do
    subject { build(:article) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:published_at) }
    it { should validate_presence_of(:external_id) }
    it { should validate_uniqueness_of(:external_id).scoped_to(:source_id) }
  end
end
