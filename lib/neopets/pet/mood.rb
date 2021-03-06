module Neopets
  class Pet
    class Mood
      attr_reader :id, :name
      
      def initialize(options)
        @id = options[:id]
        @name = options[:name]
      end
      
      def self.find(id)
        self.all_by_id[id.to_i]
      end
      
      def self.all
        @all ||= [
          Mood.new(:id => 1, :name => :happy),
          Mood.new(:id => 2, :name => :sad),
          Mood.new(:id => 4, :name => :sick)
        ]
      end
      
      def self.all_by_id
        @all_by_id ||= self.all.inject({}) { |h, m| h[m.id] = m; h }
      end
    end
  end
end
