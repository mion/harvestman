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

    def self.register(name, klass)
      @crawlers ||= {}
      @crawlers[name] = klass
    end

    def self.new(name, *args)
      if crawler = @crawlers[name]
        crawler.new(*args)
      else
        raise UnknownCrawler, "No such type: #{name}"
      end
    end

    require 'harvestman/crawler/base'
    require 'harvestman/crawler/plain'
    require 'harvestman/crawler/fast'
  end
end
