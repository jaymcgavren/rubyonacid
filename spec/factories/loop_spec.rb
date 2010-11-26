require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/loop'

include RubyOnAcid

describe LoopFactory do
  
  
  before :each do
    @it = LoopFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "Loops to 0 if increment is positive" do
    @it.interval = 0.3
    @it.get_unit(:x).should be_within(MARGIN).of(0.3)
    @it.get_unit(:x).should be_within(MARGIN).of(0.6)
    @it.get_unit(:x).should be_within(MARGIN).of(0.9)
    @it.get_unit(:x).should be_within(MARGIN).of(0.2)
    @it.get_unit(:x).should be_within(MARGIN).of(0.5)
  end
  
  it "Loops to 1 if increment is negative" do
    @it.interval = -0.3
    @it.get_unit(:x).should be_within(MARGIN).of(0.7)
    @it.get_unit(:x).should be_within(MARGIN).of(0.4)
    @it.get_unit(:x).should be_within(MARGIN).of(0.1)
    @it.get_unit(:x).should be_within(MARGIN).of(0.8)
    @it.get_unit(:x).should be_within(MARGIN).of(0.5)
  end
  
  it "handles multiple keys" do
    @it.interval = 0.3
    @it.get_unit(:x).should be_within(MARGIN).of(0.3)
    @it.get_unit(:y).should be_within(MARGIN).of(0.3)
    @it.get_unit(:x).should be_within(MARGIN).of(0.6)
    @it.get_unit(:y).should be_within(MARGIN).of(0.6)
  end
  
end