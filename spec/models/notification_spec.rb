require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    subject { build(:notification) }

    it { should validate_presence_of(:type) }
  end

  describe "scopes" do
    let!(:unread) { create(:notification, read: false) }
    let!(:read)   { create(:notification, read: true) }

    describe ".unread" do
      it "returns only unread notifications" do
        expect(Notification.unread).to include(unread)
        expect(Notification.unread).not_to include(read)
      end
    end

    describe ".read" do
      it "returns only read notifications" do
        expect(Notification.read).to include(read)
        expect(Notification.read).not_to include(unread)
      end
    end
  end
end
