require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require 'rubyonacid/generators/increment'

include RubyOnAcid

describe IncrementGenerator do
  
  MARGIN = 0.01
  
  before :each do
    @it = IncrementGenerator.new
  end
  
  it_should_behave_like "a generator"
  
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