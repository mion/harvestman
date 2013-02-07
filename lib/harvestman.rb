require "nokogiri"
require "open-uri"

require 'harvestman/version'
require 'harvestman/crawler'

module Harvestman
  # Public: Crawl a website. You can visit similar URLs (eg: pages in a search
  # result) by passing an optional argument.
  #
  # url   - A String containing the url to be crawled.
  # pages - Zero or more Strings that will replace a * in the
  #         base url. Note: this does not need to be an Array.
  # type  - Optional. You can use a "plain" (default) or "fast" crawler.
  #         Fast mode uses threads for performance.
  #
  # Example: Crawl Etsy.com, printing the title and price of each item in
  #          pages 1, 2 and 3 of the Electronics category.
  #
  # Harvestman.crawl 'http://www.etsy.com/browse/vintage-category/electronics/*', (1..3) do
  #   css "div.listing-hover" do
  #     title = css "div.title a"
  #     price = css "span.listing-price"
  #
  #     puts "* #{title} (#{price})"
  #   end
  # end
  #
  # Returns nothing.
  def self.crawl(url, pages = nil, type = :plain, &block)
    crawler = Harvestman::Crawler.new(url, pages, type)
    if block_given?
      crawler.crawl(&block)
    end
  end
end
