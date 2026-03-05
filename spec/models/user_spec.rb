require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:feeds).dependent(:destroy) }
    it { should have_many(:source_suggestions).dependent(:nullify) }
    it { should have_many(:notifications).dependent(:destroy) }
    it { should have_many(:reviewed_suggestions).dependent(:nullify) }
  end

  describe "validations" do
    subject { build(:user) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:role) }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
    it { should validate_inclusion_of(:role).in_array(User::ROLES) }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("not-an-email").for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe "admin?" do
    it "should return true for admin? when role is 'admin'" do
      user = build(:user, role: "admin")
      expect(user.admin?).to be true
    end

    it "should return false for admin? when role is not 'admin'" do
      user = build(:user, role: "user")
      expect(user.admin?).to be false
    end
  end
end
