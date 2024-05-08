require 'rails_helper'

RSpec.describe "ProductScrapers", type: :request do
  describe "POST /product_scrapers" do
    context "with valid product URL" do
      let(:valid_product_url) { "https://www.flipkart.com/black-deer-men-ethnic-top-pant-set/p/itm2f0da842d49fa" }

      it "creates a new product scraping task" do
        post "/product_scrapers", params: { product_url: valid_product_url }

        expect(response).to have_http_status(200)
        expect(json_response).to include("success", "product_id")
      end
    end

    context "with missing product URL" do
      it "returns an error message" do
        post "/product_scrapers", params: { product_url: "" }

        expect(response).to have_http_status(422)
        expect(json_response['error']).to eql("product_url can't be blank")
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
