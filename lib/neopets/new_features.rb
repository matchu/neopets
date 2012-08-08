require 'date'
require 'nokogiri'
require 'open-uri'
require 'neopets/new_features/day'

module Neopets
  module NewFeatures
    NEW_FEATURES_URL = 'http://www.neopets.com/nf.phtml'
    
    def self.recent
      read(open(NEW_FEATURES_URL).read)
    end
    
    CURRENT_NEWS_PATTERN = Regexp.new('<current_news>(.+)</current_news>', Regexp::MULTILINE)
    def self.read(html, origin_date=nil)
      origin_date ||= Date.today
      
      current_news = html.match(CURRENT_NEWS_PATTERN).captures[0].strip
      
      # Nokogiri struggles with the invalid HTML all over the New Features page,
      # so we do most of the grunt work.
      days = []
      date = nil
      title = nil
      body = ''
      current_news.each_line do |line|
        if title.nil?
          title = Nokogiri::HTML(line).text
          date_name = title.split(' - ')[0]
          date = Date.parse("#{date_name} #{origin_date.year}")
        else
          body << line + "\n"
          
          if line.start_with?('</ul>')
            days << Neopets::NewFeatures::Day.new(
              :date => date,
              :title => title,
              :body => body
            )
            
            date = nil
            title = nil
            body = ''
          end
        end
      end
      
      days
    end
  end
end
