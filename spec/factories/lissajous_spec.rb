require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/lissajous'

include RubyOnAcid

describe LissajousFactory do
  
  
  before :each do
    @it = LissajousFactory.new
  end
  
  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
    
    it "Returns x/y coordinates" do
      @it.interval = 0.5
      @it.get_unit(:x).should be_within(MARGIN).of(0.739)
      @it.get_unit(:y).should be_within(MARGIN).of(0.990)
      @it.get_unit(:x).should be_within(MARGIN).of(0.921)
      @it.get_unit(:y).should be_within(MARGIN).of(0.990)
      @it.get_unit(:x).should be_within(MARGIN).of(0.998)
      @it.get_unit(:y).should be_within(MARGIN).of(0.978)
    end
    
    it "returns x for the first assigned key, y for the second, x again for the third, etc." do
      @it.interval = 0.5
      @it.get_unit(:x).should be_within(MARGIN).of(0.739)
      @it.get_unit(:y).should be_within(MARGIN).of(0.997)
      @it.get_unit(:z).should be_within(MARGIN).of(0.739)
      @it.get_unit(:x).should be_within(MARGIN).of(0.921)
    end
    
  end  

end