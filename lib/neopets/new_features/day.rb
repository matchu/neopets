module Neopets
  module NewFeatures
    class Day
      attr_reader :date, :title, :body
      
      def initialize(options)
        @date = options[:date]
        @title = options[:title]
        @body = options[:body]
      end
    end
  end
end
