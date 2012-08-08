require 'spec_helper'
require 'neopets/new_features/day'

require 'date'

describe Neopets::NewFeatures::Day do
  it 'initializes with date, title, body' do
    day = Neopets::NewFeatures::Day.new :date => Date.new(2012, 8, 8),
                                        :title => 'Blumaroo Day',
                                        :body => 'Hooray!'
    day.date.should == Date.new(2012, 8, 8)
    day.title.should == 'Blumaroo Day'
    day.body.should == 'Hooray!'
  end
end
