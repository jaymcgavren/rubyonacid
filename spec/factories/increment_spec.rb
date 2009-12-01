require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/increment'

include RubyOnAcid

describe IncrementFactory do
  
  
  before :each do
    @it = IncrementFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "Stops at 1 if increment is positive" do
    @it.interval = 0.3
    @it.get_unit(:x).should be_close(0.3, MARGIN)
    @it.get_unit(:x).should be_close(0.6, MARGIN)
    @it.get_unit(:x).should be_close(0.9, MARGIN)
    @it.get_unit(:x).should be_close(1.0, MARGIN)
    @it.get_unit(:x).should be_close(1.0, MARGIN)
  end
  
  it "Stops at 0 if increment is negative" do
    @it.interval = -0.3
    @it.get_unit(:x).should be_close(0.7, MARGIN)
    @it.get_unit(:x).should be_close(0.4, MARGIN)
    @it.get_unit(:x).should be_close(0.1, MARGIN)
    @it.get_unit(:x).should be_close(0.0, MARGIN)
    @it.get_unit(:x).should be_close(0.0, MARGIN)
  end
  
  it "handles multiple keys" do
    @it.interval = 0.3
    @it.get_unit(:x).should be_close(0.3, MARGIN)
    @it.get_unit(:y).should be_close(0.3, MARGIN)
    @it.get_unit(:x).should be_close(0.6, MARGIN)
    @it.get_unit(:y).should be_close(0.6, MARGIN)
  end
  
end