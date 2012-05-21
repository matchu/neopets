require 'spec_helper'
require 'neopets/pet'

describe Neopets::Pet do
  it 'initializes with name' do
    pet = Neopets::Pet.new('matts_bat')
    pet.name.should == 'matts_bat'
  end
  
  it 'initializer optionally accepts gender, image url' do
    pet = Neopets::Pet.new('matts_bat', :gender => :male,
      :image_url => 'http://pets.neopets.com/cp/2gcmf37c/1/2.png')
      
    pet.gender.should == :male
    pet.image_url.should == 'http://pets.neopets.com/cp/2gcmf37c/1/2.png'
  end
  
  it 'supports #male?, #female? gender helpers' do
    pet = Neopets::Pet.new('matts_bat', :gender => :male)
    pet.male?.should == true
    pet.female?.should == false
    
    pet = Neopets::Pet.new('matts_bat', :gender => :female)
    pet.male?.should == false
    pet.female?.should == true
  end
  
  it 'parses cp, mood from image url' do
    pet = Neopets::Pet.new('matts_bat')
    
    pet.image_url = 'http://pets.neopets.com/cp/2gcmf37c/1/2.png'
    pet.cp.should == '2gcmf37c'
    pet.mood.should == :happy
    
    pet.image_url = 'http://pets.neopets.com/cp/h47bjc9g/2/2.png'
    pet.cp.should == 'h47bjc9g'
    pet.mood.should == :sad
    
    pet.image_url = 'http://pets.neopets.com/cp/s6twjtxq/4/2.png'
    pet.cp.should == 's6twjtxq'
    pet.mood.should == :sick
  end
end
