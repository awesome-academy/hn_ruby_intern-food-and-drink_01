require "rails_helper"

RSpec.describe Order, type: :model do
  describe "association" do
    it { should have_many(:order_details).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe "enum for status" do
    it { should define_enum_for(:status).with_values(pending: 0, accepted: 1, completed: 2, canceled: 3 ) }
  end

  describe "validations" do
    properties = [:name, :phone_num, :address]
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

    context "validate length of address" do
      it { should validate_length_of(:address).is_at_least(15).is_at_most(255)}
    end
  end

  describe "scope" do
    let!(:order1){FactoryBot.create :order}
    let!(:order2){FactoryBot.create :order}
    let!(:order3){FactoryBot.create :order}

    it "check scope order lastest order" do
      expect(Order.lastest_order.pluck(:id)).to eq([order3.id, order2.id, order1.id])
    end
  end

  describe "#handle_order" do
    let!(:order5){FactoryBot.create :order, status: 0}
    let!(:order_detail5){FactoryBot.create :order_detail, order_id: order5.id}
    context "when status is not complete" do
      order_params = {"status" => 1}
      it "check change status order that is not completed" do
        order5.handle_order order_params
        expect(order5.status).to eq("accepted")
      end
    end

    context "when status is completed" do
      order_params = {"status" => 2}
      it "check change status order to complete" do
        num = order_detail5.product_size.product.quantity
        order5.handle_order order_params
        order_detailt = OrderDetail.find_by order_id: order5.id
        expect(order5.status).to eq("completed")
        expect(order_detailt.product_size.product.quantity).to eq(num-1)
      end
    end

    context "Raise rescue" do
      order_params = {"status" => 5}
      it "check rescue handle order" do
        expect(order5.handle_order order_params).to eq("ERROR: '5' is not a valid status")
      end
    end
  end
end
