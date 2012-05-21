module Neopets
  class Pet
    attr_accessor :gender, :name
    attr_reader :image_url
    
    def initialize(name, options={})
      @name = name
      options.each { |key, value| self.send("#{key}=", value) }
    end
    
    def cp
      parse_image_url unless @cp
      @cp
    end
    
    def female?
      @gender == :female
    end
    
    def image_url=(url)
      @image_url = url
      
      # Expire the memoized cp and mood, since with this new URL they're no
      # longer true. By this strategy, we don't run the regex parse unless
      # we need to, but still always keep the cp/mood values up-to-date.
      @cp = nil
      @mood = nil
    end
    
    def male?
      @gender == :male
    end
    
    def mood
      parse_image_url unless @mood
      @mood
    end
    
    protected
    
    IMAGE_URL_PATTERN = %r{http://pets\.neopets\.com/cp/([a-z0-9]+)/([0-9])/[0-9]\.png}
    MOODS = {'1' => :happy, '2' => :sad, '4' => :sick}
    def parse_image_url
      @cp, mood_code = @image_url.match(IMAGE_URL_PATTERN).captures
      @mood = MOODS[mood_code]
    end
  end
end
