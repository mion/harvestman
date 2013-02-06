module Harvestman
  module Crawler
    class Base
      def initialize(base_url, pages)
        @base_url = base_url
        @pages = pages
      end

      protected

      def crawl_url(url, &block)
        parser = Parser.new(url)
        parser.instance_eval(&block)
      end
    end
  end
end
