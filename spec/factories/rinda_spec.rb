require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/rinda'

include RubyOnAcid

describe RindaFactory do
  
  
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
  
  it "gets keys from a backup factory when it cannot retrieve values via Rinda" do
    @it.start_service
    default_factory = mock('Factory')
    default_factory.stub!(:get_unit).and_return(0.74)
    @it.default_factory = default_factory
    @it.get_unit(:a).should == 0.74
  end
  
end