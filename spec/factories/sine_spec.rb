require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/sine'

include RubyOnAcid

describe SineFactory do
  
  
  before :each do
    @it = SineFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "loops between 0 and 1" do
    @it.interval = 1.0
    @it.get_unit(:x).should be_within(MARGIN).of(0.920)
    @it.get_unit(:x).should be_within(MARGIN).of(0.954)
    @it.get_unit(:x).should be_within(MARGIN).of(0.570)
    @it.get_unit(:x).should be_within(MARGIN).of(0.122)
    @it.get_unit(:x).should be_within(MARGIN).of(0.020)
    @it.get_unit(:x).should be_within(MARGIN).of(0.360)
  end
  
  it "can take a different interval" do
    @it.interval = 0.5
    @it.get_unit(:x).should be_within(MARGIN).of(0.740)
    @it.get_unit(:x).should be_within(MARGIN).of(0.920)
  end
  
  it "handles multiple keys" do
    @it.interval = 1.0
    @it.get_unit(:x).should be_within(MARGIN).of(0.920)
    @it.get_unit(:y).should be_within(MARGIN).of(0.920)
    @it.get_unit(:x).should be_within(MARGIN).of(0.954)
    @it.get_unit(:y).should be_within(MARGIN).of(0.954)
  end
  
end