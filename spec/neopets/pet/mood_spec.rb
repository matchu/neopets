require 'spec_helper'
require 'neopets/pet/mood'

describe Neopets::Pet::Mood do
  describe '.find' do
    it 'finds happy by ID 1' do
      mood = Neopets::Pet::Mood.find('1')
      mood.id.should == 1
      mood.name.should == 'Happy'
    end
    
    it 'finds sad by ID 2' do
      mood = Neopets::Pet::Mood.find('2')
      mood.id.should == 2
      mood.name.should == 'Sad'
    end
    
    it 'finds sick by ID 4' do
      mood = Neopets::Pet::Mood.find('4')
      mood.id.should == 4
      mood.name.should == 'Sick'
    end
  end
  
  describe '.all' do
    it 'contains happy, sad, and sick in that order' do
      moods = Neopets::Pet::Mood.all
      moods.map(&:id).should == [1, 2, 4]
      moods.map(&:name).should == %w(Happy Sad Sick)
    end
  end
end
