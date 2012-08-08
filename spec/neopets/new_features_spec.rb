require 'spec_helper'
require 'neopets/new_features'
require 'webmock/rspec'

describe Neopets::NewFeatures do
  describe '.read' do
    it 'reads an HTML source string, returning a corresponding array of Days' do
      days = Neopets::NewFeatures.read(web_sample('nf/20120808.html'))
      
      days[0].date.should == Date.new(2012, 8, 8)
      days[0].title.should == '8th August - Blumaroo Day'
      days[0].body.gsub(/^\s+/, '').should == <<-EOF
<ul>
<p>
<li><b>[8th August 1]</b>
</p>
<p>
<li><b>[8th August 2]</b>
</p>
</ul>
      EOF
      
      days[1].date.should == Date.new(2012, 8, 7)
      days[1].title.should == '7th August'
      days[1].body.gsub(/^\s+/, '').should == <<-EOF
<ul>
<p>
<li><i>[7th August 1]</i>
</p>
<p>
<li><i>[7th August 2]</i>
</p>
</ul>
      EOF
    end
  end
  
  describe '.recent' do
    it 'downloads the current nf.phtml and reads it' do
      stub_request(:get, 'http://www.neopets.com/nf.phtml').
        to_return(:status => 200, :body => 'Hello, world!')
      
      Neopets::NewFeatures.should_receive(:read).with('Hello, world!').
        and_return(['Day 1', 'Day 2'])
      
      Neopets::NewFeatures.recent.should == ['Day 1', 'Day 2']
    end
  end
end
