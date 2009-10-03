require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require "rubyonacid/generators/random"

include RubyOnAcid

describe RandomGenerator do
  
  before :each do
    @it = RandomGenerator.new
  end
  
  it_should_behave_like "a generator"
  
  it "generates random numbers between 0 and 1" do
    @it.get_unit(:x).should_not == @it.get_unit(:x)
    @it.get_unit(:x).should_not == @it.get_unit(:x)
  end
  
end