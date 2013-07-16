require 'harvestman'

# Crawl Etsy's electronics category pages (from 1 to 3) and output every item's
# title and price.

base_url = 'http://www.etsy.com/browse/vintage-category/electronics/*'

Harvestman.crawl base_url, (1..3) do
  css "div.listing-hover" do
    title = css "div.title a"
    price = css "span.listing-price"

    puts "* #{title} (#{price})"
  end
end
