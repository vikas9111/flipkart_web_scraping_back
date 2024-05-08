class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :products

  def products
    object.products.map do |product|
      ProductSerializer.new(product, include_category: false)
    end
  end
end
