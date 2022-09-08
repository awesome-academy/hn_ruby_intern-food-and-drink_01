require "rails_helper"

RSpec.describe Product, type: :model do
  describe "association" do
    it { should have_many(:product_sizes).dependent(:destroy) }
    it { should have_many(:sizes).through(:product_sizes) }
    it { should have_one_attached(:image) }
    it { should belong_to(:category) }
  end

  describe "validations" do
    properties = [:name, :unit_price, :description, :image]
    context "validate presence" do
      properties.each do |property|
      it { should validate_presence_of property }
      end
    end
  end

  describe "scope" do
    let!(:product1){FactoryBot.create :product, name: "salad", description: "sfsdfsfj", unit_price: "89", quantity: "10"}
    let!(:product2){FactoryBot.create :product, name: "beef", description: "sfsdfsfj", unit_price: "50", quantity: "12" }
    let!(:product3){FactoryBot.create :product, name: "wine", description: "sfsdfsfj", unit_price: "60", quantity: "15" }

    it "asc_name" do
      expect(Product.asc_name.pluck(:id)).to eq([product2.id, product1.id, product3.id])
    end

    it "desc_name" do
      expect(Product.desc_name.pluck(:id)).to eq([product3.id, product1.id, product2.id])
    end

    it "lastest" do
      expect(Product.lastest.pluck(:id)).to eq([product3.id, product2.id, product1.id])
    end

    it "newest" do
      expect(Product.newest.pluck(:id)).to eq([product3.id, product2.id, product1.id])
    end
  end
end
