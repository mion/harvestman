module Harvestman
  module Crawler
    # Raised when the requested page did not respond.
    class RequestError < SocketError; end
    # Raised when given URL is invalid.
    class URLError < ArgumentError; end
    # Raised when one of the elements in the pages array does not implement to_s.
    class PageError < ArgumentError; end
    # Raised when given crawler type is not registered.
    class UnknownCrawler < ArgumentError; end

    def self.register(type, klass)
      @crawlers ||= {}
      @crawlers[type] = klass
    end

    def self.new(base_url, pages, type)
      if crawler = @crawlers[type]
        crawler.new(base_url, pages)
      else
        raise UnknownCrawler, "No such type: #{type}"
      end
    end

    require 'harvestman/crawler/parser'
    require 'harvestman/crawler/base'
    require 'harvestman/crawler/plain'
    require 'harvestman/crawler/fast'
  end
end
