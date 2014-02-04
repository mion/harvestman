module Harvestman
  module Crawler
    class Parser
      def initialize(url)
        @uri = URI.parse(url)
        @document = Nokogiri::HTML(open(@uri))
      end

      def css(path, &block)
        parse(:css, path, &block)
      end

      def xpath(path, &block)
        parse(:xpath, path, &block)
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
