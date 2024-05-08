product_urls = [
    "https://www.flipkart.com/flokestone-analog-watch-men/p/itm34cb62239620f",
    "https://www.flipkart.com/empeno-trendy-lightweight-nagra-mojaris-men/p/itmfa68384fcace0",
    "https://www.flipkart.com/black-deer-men-ethnic-top-pant-set/p/itm2f0da842d49fa",
    "https://www.flipkart.com/red-tape-sports-athleisure-shoes-men-soft-cushioned-insole-slip-resistance-walking/p/itm5442f5743fd45"
  ]
product_urls.each do |product_url|
  product = ScrapingProductService.new(product_url).scrape_product
end

puts "Seed Run Successfully"