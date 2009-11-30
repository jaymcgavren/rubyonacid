require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require "rubyonacid/factories/random"

include RubyOnAcid

describe RandomFactory do
  
  before :each do
    @it = RandomFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "generates random numbers between 0 and 1" do
    @it.get_unit(:x).should_not == @it.get_unit(:x)
    @it.get_unit(:x).should_not == @it.get_unit(:x)
  end
  
end