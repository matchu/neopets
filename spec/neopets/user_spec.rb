require 'spec_helper'
require 'neopets/pet'
require 'neopets/user'
require 'webmock/rspec'

describe Neopets::User do
  describe '.new' do
    it 'initializes with username' do
      user = Neopets::User.new('dirtside')
      user.username.should == 'dirtside'
    end
  end
  
  describe '#pets' do
    it 'has pets' do
      stub_request(:get, 'http://www.neopets.com/userlookup.phtml?user=dirtside').
        to_return(:status => 200, :body => web_sample('userlookup/dirtside.html'))
      
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
    
    it 'raises NotFoundError when user does not exist' do
      stub_request(:get, 'http://www.neopets.com/userlookup.phtml?user=jlkjglkejsklrajfdoi').
        to_return(:status => 200, :body => web_sample('userlookup/not_found.html'))
      
      user = Neopets::User.new('jlkjglkejsklrajfdoi')
      lambda { user.pets }.should raise_error(Neopets::User::NotFoundError)
      lambda { user.pets }.should raise_error(Neopets::User::Error) # ensure properly subclassed
    end
    
    it 'raises AccountDisabledError when user has been frozen' do
      stub_request(:get, 'http://www.neopets.com/userlookup.phtml?user=poop').
        to_return(:status => 200, :body => web_sample('userlookup/account_disabled.html'))
      
      user = Neopets::User.new('poop')
      lambda { user.pets }.should raise_error(Neopets::User::AccountDisabledError)
      lambda { user.pets }.should raise_error(Neopets::User::Error) # ensure properly subclassed
    end
    
    it 'raises ConnectionError when userlookup request fails' do
      stub_request(:get, 'http://www.neopets.com/userlookup.phtml?user=dirtside')
        .to_return(:status => 503, :body => 'Down for Maintenance')
      
      user = Neopets::User.new('dirtside')
      lambda { user.pets }.should raise_error(Neopets::User::ConnectionError)
      lambda { user.pets }.should raise_error(Neopets::User::Error) # ensure properly subclassed
    end
  end
end
