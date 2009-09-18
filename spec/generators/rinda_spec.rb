require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require 'generators/rinda'

describe RubyOnAcid::RindaGenerator do
  
  MARGIN = 0.01
  
  before :each do
    @it = RubyOnAcid::RindaGenerator.new
    @it.uri = "druby://127.0.0.1:9999"
    require 'rinda/rinda'
    DRb.start_service
    @space = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, @it.uri)) 
  end
  
  it_should_behave_like "a generator"
  
  it "gets keys from Rinda server" do
    @it.start_service
    @space.write([:x, 0.5])
    @it.get(:x).should == 0.5
    @space.write([:y, 0.6])
    @it.get(:x).should == 0.6
  end
  
end