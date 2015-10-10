require 'thread'

module Harvestman
  module Crawler
    class Fast < Base
      def crawl(&block)
        if @pages.nil?
          crawl_url(@base_url, &block)
        else
          # started_at = Time.now
          urls = @pages.map { |p| @base_url.gsub('*', p.to_s) }
          work_q = Queue.new
          urls.each { |url| work_q << url }
          workers = (0...5).map do
            Thread.new do
              begin
                while url = work_q.pop(true)
                  begin
                    crawl_url(url, &block)
                  rescue => e
                    puts "[!] Error in URL: #{url}"
                    puts e.inspect
                  end
                end
              rescue ThreadError
              end
            end
          end
          workers.map(&:join)

          # threads = []
          # @pages.each do |p|
          #   threads << Thread.new(p) { |page| crawl_url(@base_url.gsub('*', p.to_s), &block) }
          # end
          # threads.each { |t| t.join }
        end
      end
    end

    register :fast, Fast
  end
end
