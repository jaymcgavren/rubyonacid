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
  
end