require 'spec_helper'
require 'neopets/pet'
require 'neopets/user'
require 'webmock/rspec'

describe Neopets::User do
  before do
    stub_request(:get, 'http://www.neopets.com/userlookup.phtml?user=dirtside').
      to_return(:status => 200, :body => web_sample('userlookup/dirtside.html'))
  end
  
  it 'initializes with username' do
    user = Neopets::User.new('dirtside')
    user.username.should == 'dirtside'
  end
  
  it 'has pets' do
    user = Neopets::User.new('dirtside')
    
    # stub dirtside's pets
    pets = [double('enkerethor'), double('gelbon'), double('rohane2000'), double('teramenor')]
    
    Neopets::Pet.stub(:new).with(
      'Enkerethor',
      :gender => :male,
      :image_url => 'http://pets.neopets.com/cp/2gcmf37c/1/2.png'
    ).and_return(pets[0])
    
    Neopets::Pet.stub(:new).with(
      'Gelbon',
      :gender => :male,
      :image_url => 'http://pets.neopets.com/cp/mb4mcwj5/1/2.png'
    ).and_return(pets[1])
    
    Neopets::Pet.stub(:new).with(
      'Rohane2000',
      :gender => :female,
      :image_url => 'http://pets.neopets.com/cp/wbz2n3f8/1/2.png'
    ).and_return(pets[2])
    
    Neopets::Pet.stub(:new).with(
      'Teramenor',
      :gender => :male,
      :image_url => 'http://pets.neopets.com/cp/gbwflsho/2/2.png'
    ).and_return(pets[3])
    
    user.pets.should == pets
  end
end
