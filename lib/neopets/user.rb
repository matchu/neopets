require 'nokogiri'
require 'open-uri'
require 'neopets/pet'

module Neopets
  class User
    class Error < RuntimeError; end
    class AccountDisabledError < Error; end
    class ConnectionError < Error; end
    class NotFoundError < Error; end
    
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
      doc = open_doc(userlookup_url)
      user_node = doc.css('#userneopets').last # apparently users can make extra #userneopets nodes <_<
      unless user_node
        if doc.css('#content td.content b').last.content == 'This account has been disabled.'
          raise AccountDisabledError, "User #{@username.inspect} has been frozen"
        else
          raise NotFoundError, "User #{@username.inspect} not found on Neopets.com"
        end
      end
      
      pet_nodes = user_node.css('td.contentModuleContent td')
      @pets = pet_nodes.map { |n| pet_from_node(n) }
    end
    
    def open_doc(url)
      begin
        source = open(url)
      rescue Exception => e
        raise ConnectionError, "request to #{url.inspect} raised #{e.class}: #{e.message}"
      end
      Nokogiri::HTML(source)
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
