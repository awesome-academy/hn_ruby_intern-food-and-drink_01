require 'rails_helper'

RSpec.describe "OrderDeatails", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/order_deatails/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/order_deatails/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/order_deatails/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
