require "nokogiri"
require "open-uri"

['version',
 'crawler/plain',
 'crawler/fast').each do |file|
  require "harvestman/#{file}"
end

module Harvestman
  # Public: Crawl a website. You can visit similar URLs (eg: pages in a search
  # result) by passing an optional argument.
  #
  # url   - A String containing the url to be crawled.
  # pages - Zero or more Strings that will replace a * in the
  #         base url. Note: this does not need to be an Array.
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
  def self.crawl(url, pages = nil, &block)
    client = Harvestman::Crawler.new(url, pages, &block)
  end

  def self.crawl(url, pages = nil, &block)
    if pages.nil?
      crawl_url(url, &block)
    else
      Thread.abort_on_exception = true
      threads = []
      pages.each do |page|
        threads << Thread.new(page) do |p|
          current_url = url.gsub('*', p.to_s)

          crawl_url(current_url, &block)
        end
      end
      threads.each { |t| t.join }
    end
  end

  private

  def self.crawl_url(url, &block)
    crawler = Crawler.new(url)
    mutex = Mutex.new
    mutex.synchronize { crawler.instance_eval(&block) }
  end
end
