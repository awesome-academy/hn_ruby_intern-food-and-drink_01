require "rails_helper"

RSpec.describe User, type: :model do
  describe "association" do
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe "enum for role" do
    it { should define_enum_for(:role).with_values(admin: 0, customer: 1) }
  end

  describe "validations" do
    properties = [:name, :phone_num, :address, :email, :password]
    context "validate presence" do
      properties.each do |property|
      it { should validate_presence_of property }
      end
    end

    context "validate length of name" do
      it { should validate_length_of(:name).is_at_most(Settings.user.name.name_max_length)}
    end

    context "validate length of phone_num" do
      it { should validate_length_of(:phone_num).is_equal_to(Settings.user.phone.phone_length)}
    end

    context "validate length of password" do
      it { should validate_length_of(:password).is_at_least(Settings.user.password.password_min)}
    end

    context "validate length of email" do
      it { should validate_length_of(:email).is_at_least(10).is_at_most(255)}
    end

    context "validate length of address" do
      it { should validate_length_of(:address).is_at_least(15).is_at_most(255)}
    end

    context "validate unique of email" do
      subject { FactoryBot.build(:user) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context "validate unique of phone number" do
      subject { FactoryBot.build(:user) }
      it { should validate_uniqueness_of(:phone_num).case_insensitive }
    end

    context "when email format" do
      it {should allow_value("asd234@gmail.com").for(:email)}
    end

    context "when email wrong format" do
      it {should_not allow_value("asdasdsa").for(:email)}
    end

    context "when phone number format" do
      it {should allow_value("0123456789").for(:phone_num)}
    end

    context "when phone number wrong format" do
      it {should_not allow_value("012345678a").for(:phone_num)}
    end
  end

  describe "secure password" do
    it { should have_secure_password }
  end

  describe "scope" do
    let!(:user1){FactoryBot.create :user, name: "nam"}
    let!(:user2){FactoryBot.create :user, name: "than"}
    let!(:user3){FactoryBot.create :user, name: "minh"}
    it "check scope user name asc" do
      expect(User.name_asc.pluck(:id)).to eq([user3.id, user1.id, user2.id])
    end
  end

  describe "downcase email" do
    let!(:user_email) {FactoryBot.create :user, email: "THANMINHNAM1239@gmail.com"}
    it "check before save downcase email" do
      user_email.email.should eq("thanminhnam1239@gmail.com")
    end
  end
end
