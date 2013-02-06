module Harvestman
  module Crawler
    class Fast < Base
      def crawl(&block)
        if @pages.nil?
          crawl_url(@base_url, &block)
        else
          threads = []
          @pages.each do |p|
            threads << Thread.new(p) { |page| crawl_url(@base_url.gsub('*', p.to_s)) }
          end
          threads.each { |t| t.join }
        end
      end
    end

    register :fast, Fast
  end
end
