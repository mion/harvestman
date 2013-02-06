module Harvestman
  module Crawler
    class Plain < Base
      def crawl(&block)
        if @pages.nil?
          crawl_url(@base_url, &block)
        else
          @pages.each do |p|
            crawl_url(@base_url.gsub('*', p.to_s))
          end
        end
      end
    end

    register :plain, Plain
  end
end
