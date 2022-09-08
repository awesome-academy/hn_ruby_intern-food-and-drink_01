require "rails_helper"

RSpec.describe Category, type: :model do
  describe "association" do
    it { should have_many(:products).dependent(:nullify) }
  end

  describe "validation" do
    context "validate presence" do
      it { should validate_presence_of :name }
    end

    context "validate unique of name" do
      subject{ FactoryBot.build(:category) }
      it { should validate_uniqueness_of(:name).case_insensitive }
    end
  end

  describe "scope" do
    let!(:category1){ FactoryBot.create :category, name: "abcdef" }
    let!(:category2){ FactoryBot.create :category, name: "cbafed" }
    let!(:category3){ FactoryBot.create :category, name: "cabfed" }
    it "check scope asc name category" do
      expect(Category.asc_name.pluck(:id)).to eq([category1.id, category3.id, category2.id])
    end
  end
end
