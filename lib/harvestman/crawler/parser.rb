module Harvestman
  module Crawler
    class Parser
      def initialize(url)
        @url = url
        @doc = Nokogiri::HTML(open(url))
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
          @doc.send(path_type, path).each do |node|
            doc = @doc
            @doc = node
            instance_eval(&block)
            @doc = doc
          end
        else
          @doc.send(path_type, path)
        end
      end
    end
  end
end
