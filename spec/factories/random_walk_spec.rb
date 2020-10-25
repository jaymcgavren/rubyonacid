require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/random_walk'

include RubyOnAcid

describe RandomWalkFactory do
  
  
  subject do
    RandomWalkFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "increases or decreases prior key value by random amount within given interval" do
    values = []
    values << subject.get_unit(:x)
    subject.interval = 0.3
    values << subject.get_unit(:x)
    values[1].should be_within(0.3).of(values[0])
    subject.interval = 0.01
    values << subject.get_unit(:x)
    values[2].should be_within(0.01).of(values[1])
  end
  
  it "new instances produce the same output if given same random number generator seed" do
    factory_1 = RandomWalkFactory.new(rng_seed: 42)
    factory_2 = RandomWalkFactory.new(rng_seed: 42)
    factory_1.get_unit(:x).should be_within(0.0001).of(factory_2.get_unit(:x))
    factory_1.get_unit(:x).should be_within(0.0001).of(factory_2.get_unit(:x))
  end
  
  it "adds random amount within given interval to source factories result if source factories are assigned"
  
end
