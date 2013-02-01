require 'spec_helper'
require 'neopets/pet/mood'

describe Neopets::Pet::Mood do
  describe '.find' do
    it 'finds happy by ID 1' do
      mood = Neopets::Pet::Mood.find('1')
      mood.id.should == 1
      mood.name.should == :happy
    end
    
    it 'finds sad by ID 2' do
      mood = Neopets::Pet::Mood.find('2')
      mood.id.should == 2
      mood.name.should == :sad
    end
    
    it 'finds sick by ID 4' do
      mood = Neopets::Pet::Mood.find('4')
      mood.id.should == 4
      mood.name.should == :sick
    end
  end
  
  describe '.all' do
    it 'contains happy, sad, and sick in that order' do
      moods = Neopets::Pet::Mood.all
      moods.map(&:id).should == [1, 2, 4]
      moods.map(&:name).should == [:happy, :sad, :sick]
    end
  end
end
