require 'rails_helper'

RSpec.describe "Products", type: :request do
  before do
    @product1 = ScrapingProductService.new("https://www.flipkart.com/black-deer-men-ethnic-top-pant-set/p/itm2f0da842d49fa").scrape_product
    @product2 = ScrapingProductService.new("https://www.flipkart.com/studio-men-embellished-straight-kurta/p/itm4aaf9b9167787").scrape_product
  end
  describe "GET /products" do
    context "with search keyword" do
      it "returns products matching the search keyword" do
        get "/products", params: { search_keyword: "Men Embellished" }

        expect(response).to have_http_status(200)
  
        expect(json_response.length).to eq(1)
        expect(json_response.first["products"].first["title"]).to eq( @product2.title)
      end
    end

    # Add more context and examples for filtering and sorting if needed

    def json_response
      JSON.parse(response.body)
    end
  end

  describe "GET /products/:id" do
    context "with existing product ID" do
      it "returns the product details" do        
        get "/products/#{@product2.id}"

        expect(response).to have_http_status(200)
        expect(json_response["title"]).to eq(@product2.title)
        expect(json_response["price"]).to eq(@product2.price.to_f.to_s)
      end
    end

    context "with non-existing product ID" do
      it "returns an error message" do
        get "/products/99999"

        expect(response).to have_http_status(404)
        expect(json_response["error"]).to eq("Product not found")
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
