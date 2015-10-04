module Harvestman
  module Crawler
    class Parser
      def initialize(url)
        @url = url
        @document = Nokogiri::HTML(open(url))
      end

      def css(path, &block)
        parse(:css, path, &block)
      end

      def xpath(path, &block)
        parse(:xpath, path, &block)
      end

      def current_uri
        URI.parse(@url)
      end

      private

      def parse(path_type, path, &block)
        if block_given?
          @document.send(path_type, path).each do |node|
            doc = @document
            @document = node
            instance_eval(&block)
            @document = doc
          end
        else
          @document.send("at_#{path_type}", path).inner_text
        end
      end
    end
  end
end
