require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/rinda'

include RubyOnAcid

describe RindaFactory do
  
  MARGIN = 0.01
  
  before :each do
    @it = RindaFactory.new
    uri = "druby://127.0.0.1:9999"
    @it.uri = uri
    require 'rinda/rinda'
    require 'rinda/tuplespace'
    DRb.start_service
    DRb.start_service(uri, Rinda::TupleSpace.new) 
    @space = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, @it.uri)) 
  end
  
  it_should_behave_like "a factory"
  
  it "gets keys from Rinda server" do
    @it.start_service
    @space.write([:x, 0.5])
    @it.get_unit(:x).should == 0.5
    @space.write([:y, 0.6])
    @it.get_unit(:x).should == 0.6
  end
  
end