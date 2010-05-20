require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/random_walk'

include RubyOnAcid

describe RandomWalkFactory do
  
  
  before :each do
    @it = RandomWalkFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "increases or decreases prior key value by random amount within given interval" do
    values = []
    values << @it.get_unit(:x)
    @it.interval = 0.3
    values << @it.get_unit(:x)
    values[1].should be_close(values[0], 0.3)
    @it.interval = 0.01
    values << @it.get_unit(:x)
    values[2].should be_close(values[1], 0.01)
  end
  
  it "adds random amount within given interval to source factories result if source factories are assigned"
  
end