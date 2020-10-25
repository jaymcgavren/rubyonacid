require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/lissajous'

include RubyOnAcid

describe LissajousFactory do
  
  
  subject do
    LissajousFactory.new
  end
  
  describe "general behavior" do
  
    before :each do
      subject.source_factories << double('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
    
    it "Returns x/y coordinates" do
      subject.interval = 0.5
      subject.get_unit(:x).should be_within(MARGIN).of(0.739)
      subject.get_unit(:y).should be_within(MARGIN).of(0.990)
      subject.get_unit(:x).should be_within(MARGIN).of(0.921)
      subject.get_unit(:y).should be_within(MARGIN).of(0.990)
      subject.get_unit(:x).should be_within(MARGIN).of(0.998)
      subject.get_unit(:y).should be_within(MARGIN).of(0.978)
    end
    
    it "returns x for the first assigned key, y for the second, x again for the third, etc." do
      subject.interval = 0.5
      subject.get_unit(:x).should be_within(MARGIN).of(0.739)
      subject.get_unit(:y).should be_within(MARGIN).of(0.997)
      subject.get_unit(:z).should be_within(MARGIN).of(0.739)
      subject.get_unit(:x).should be_within(MARGIN).of(0.921)
    end
    
  end  

end
