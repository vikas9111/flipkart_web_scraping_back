class ProductsController < ApplicationController
  
  def index
    categories = Category.includes(:products)
    if params[:search_keyword].present?
      categories = categories.joins(:products).where('LOWER(products.title) LIKE ? OR LOWER(categories.title) LIKE ?', "%#{params[:search_keyword].downcase}%", "%#{params[:search_keyword].downcase}%")
    end

    # Filter products by price range
    if params[:min_price].present? && params[:max_price].present?
      categories = categories.joins(:products).where(products: { price: params[:min_price].to_f..params[:max_price].to_f })
    elsif params[:min_price].present?
      categories = categories.joins(:products).where('products.price >= ?', params[:min_price].to_f)
    elsif params[:max_price].present?
      categories = categories.joins(:products).where('products.price <= ?', params[:max_price].to_f)
    end

    # Sort products by price
    if params[:sort_by] == 'price'
      order = params[:order] == 'asc' ? 'ASC' : 'DESC'
      categories = categories.joins(:products).order("products.price #{order}")
    end
    render json: categories, each_serializer: CategorySerializer
  end

  def show
    product = Product.find(params[:id])
    render json: product, serializer: ProductSerializer, include_category: true
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product not found' }, status: :not_found
  end
end
