require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require "generators/random"

describe RubyOnAcid::RandomGenerator do
  
  before :each do
    @it = RubyOnAcid::RandomGenerator.new
  end
  
  it_should_behave_like "a generator"
  
  it "generates random numbers between 0 and 1" do
    @it.get(:x).should_not == @it.get(:x)
    @it.get(:x).should_not == @it.get(:x)
  end
  
end