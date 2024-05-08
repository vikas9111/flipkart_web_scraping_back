class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :size, :details

  attribute :category_id, if: -> { instance_options[:include_category] }
  attribute :category_title, if: -> { instance_options[:include_category] }

  def category_id
    object.category.id
  end

  def category_title
    object.category.title
  end
end
