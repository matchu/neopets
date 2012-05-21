module Neopets
  class Pet
    attr_accessor :cp, :gender, :mood, :name
    
    def initialize(name, options={})
      @name = name
      options.each { |key, value| self.send("#{key}=", value) }
    end
    
    def female?
      @gender == :female
    end
    
    IMAGE_URL_PATTERN = %r{http://pets\.neopets\.com/cp/([a-z0-9]+)/([0-9])/[0-9]\.png}
    MOODS = {'1' => :happy, '2' => :sad, '4' => :sick}
    def image_url=(url)
      @cp, mood_code = url.match(IMAGE_URL_PATTERN).captures
      @mood = MOODS[mood_code]
    end
    
    def male?
      @gender == :male
    end
  end
end
