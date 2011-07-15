require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/constant'

include RubyOnAcid

describe ConstantFactory do
  
  
  subject do
    ConstantFactory.new
  end
  
  it_should_behave_like "a factory"
  

  it "always returns the same value" do
    subject.value = 0.1
    subject.get_unit(:x).should == 0.1
    subject.get_unit(:x).should == 0.1
  end
  
end