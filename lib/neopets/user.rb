require 'nokogiri'
require 'open-uri'
require 'neopets/pet'

module Neopets
  class User
    attr_reader :username
    
    def initialize(username)
      @username = username
    end
    
    def pets
      load_userlookup unless @pets
      @pets
    end
    
    protected
    
    def load_userlookup
      doc = Nokogiri::HTML(open(userlookup_url))
      pet_nodes = doc.css('#userneopets td.contentModuleContent td')
      @pets = pet_nodes.map { |n| pet_from_node(n) }
    end
    
    def pet_from_node(node)
      bolds = node.css('b')
      
      Pet.new(bolds[0].content,
        :gender => (bolds[1].content == 'Male' ? :male : :female),
        :image_url => node.at('img')['src']
      )
    end
    
    def userlookup_url
      "http://www.neopets.com/userlookup.phtml?user=#{username}"
    end
  end
end
