require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require "rubyonacid/factories/random"

include RubyOnAcid

describe RandomFactory do
  
  subject do
    RandomFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "generates random numbers between 0 and 1" do
    subject.get_unit(:x).should_not == subject.get_unit(:x)
    subject.get_unit(:x).should_not == subject.get_unit(:x)
  end
  
  it "new instances produce the same output if given same random number generator seed" do
    factory_1 = RandomFactory.new(rng_seed: 42)
    factory_2 = RandomFactory.new(rng_seed: 42)
    factory_1.get_unit(:x).should be_within(0.0001).of(factory_2.get_unit(:x))
    factory_1.get_unit(:x).should be_within(0.0001).of(factory_2.get_unit(:x))
  end
  
end
