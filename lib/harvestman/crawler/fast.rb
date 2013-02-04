module Harvestman
  module Crawler
    class Fast < Base
      def crawl(url, pages = nil, &block)
    end

    register :fast, Fast
  end
end
