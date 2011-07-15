require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/rinda'

include RubyOnAcid

require 'rinda/rinda'
require 'rinda/tuplespace'
DRb.start_service
DRb.start_service("druby://127.0.0.1:7632", Rinda::TupleSpace.new) 

describe RindaFactory do
  
  subject do
    factory = RindaFactory.new
    factory.uri = "druby://127.0.0.1:7632"
    @space = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, factory.uri))
    factory
  end
  
  describe "general behavior" do
  
    before :each do
      subject.start_service
    end
  
    it_should_behave_like "a factory"
    
  end
  
  it "gets keys from Rinda server" do
    subject.start_service
    @space.write([:x, 0.5])
    subject.get_unit(:x).should == 0.5
    @space.write([:y, 0.6])
    subject.get_unit(:y).should == 0.6
  end
  
  it "gets keys from a backup factory when it cannot retrieve values via Rinda" do
    subject.start_service
    default_factory = mock('Factory')
    default_factory.stub!(:get_unit).and_return(0.74)
    subject.source_factories << default_factory
    subject.get_unit(:a).should == 0.74
  end
  
end
