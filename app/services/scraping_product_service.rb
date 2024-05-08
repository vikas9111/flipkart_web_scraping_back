class ScrapingProductService
  require 'nokogiri'
  require 'httparty'

  def initialize(url)
    @url = url
  end

  def scrape_product
    response = HTTParty.get(@url, headers: { 'Referer' => '' })
    doc = Nokogiri::HTML(response.body)
    @category_name = doc.at_css("._7dPnhA").children[1].at_css(".R0cyWM").text
    @product_title = doc.at_css(".VU-ZEz").text
    @size = doc.at_css(".CDDksN.zmLe5G.dpZEpc")&.text
    @details = {}
    doc.css('.sBVJqn .row').each do |row|
      key = row.at_css('.col-3-12').text.strip
      value = row.at_css('.col-9-12').text.strip
      @details[key] = value
    end
    @price = doc.css(".hl05eU .Nx9bqj.CxhGGd").text.gsub("₹", "").to_i

    build_category
    build_product
  end

  def build_category
    @category = Category.where('lower(title) = ?', @category_name.downcase).first
    @category ||= Category.create(title: @category_name)
  end

  def build_product
    @product = @category.products.where('lower(title) = ?', @product_title.downcase).first
    if @product.nil?
      # If product doesn't exist, create a new one
      @product = @category.products.create(
        title: @product_title,
        size: @size,
        details: @details,
        price: @price
      )
    else
      # If product exists, update its attributes
      @product.update(
        size: @size,
        details: @details,
        price: @price
      )
    end
  
    @product  
  end
end