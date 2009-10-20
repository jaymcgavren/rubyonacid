require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/constant'

include RubyOnAcid

describe ConstantFactory do
  
  MARGIN = 0.01
  
  before :each do
    @it = ConstantFactory.new
  end
  
  it_should_behave_like "a factory"
  

  it "always returns the same value" do
    @it.value = 0.1
    @it.get_unit(:x).should == 0.1
    @it.get_unit(:x).should == 0.1
  end
  
end