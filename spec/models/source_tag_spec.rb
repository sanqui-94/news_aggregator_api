require "rails_helper"

RSpec.describe SourceTag, type: :model do
  describe "associations" do
    it { should belong_to(:source) }
    it { should belong_to(:tag) }
  end
end
