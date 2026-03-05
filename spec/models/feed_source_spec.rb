require "rails_helper"

RSpec.describe FeedSource, type: :model do
  describe "associations" do
    it { should belong_to(:feed) }
    it { should belong_to(:source) }
  end
end
