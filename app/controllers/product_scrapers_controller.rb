class ProductScrapersController < ApplicationController
  before_action :validate_product_url

  def create
    product = ScrapingProductService.new(scrap_params[:product_url]).scrape_product
    
    if product.errors.present?
      render json: {error: product.errors.full_message}, status: 422
    else
      render json: {success: "Successfully scraped product", product_id: product.id}, status: 200
    end
  rescue StandardError => e
    render json: {error: e}, status: 422
  end


  private

  def validate_product_url
    return true if params[:product_url].present?
    render json: {error: "product_url can't be blank"}, status: 422
  end

  def scrap_params
    params.permit(:product_url)
  end
end
