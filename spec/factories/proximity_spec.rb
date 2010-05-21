require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/factories/proximity'
require "shared_factory_specs"

include RubyOnAcid

describe ProximityFactory do
  
  before :each do
    @it = ProximityFactory.new
  end

  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
    it "requests value from the source factory and scales it based on its proximity to the target value" do
      source_factory = mock('Factory')
      @it.source_factories << source_factory
      @it.target = 0.5
      source_factory.should_receive(:get_unit).with(:x).and_return(0.5)
      near_value = @it.get_unit(:x)
      source_factory.should_receive(:get_unit).with(:x).and_return(0.7)
      far_value = @it.get_unit(:x)
      near_value.should > far_value
    end
    
    it "should return 1.0 if source value matches target exactly" do
      source_factory = mock('Factory')
      @it.source_factories << source_factory
      @it.target = 0.5
      source_factory.should_receive(:get_unit).with(:x).and_return(0.5)
      @it.get_unit(:x).should be_close(1.0, MARGIN)
    end
    
    it "should approach zero as distance approaches 1.0" do
      source_factory = mock('Factory')
      @it.source_factories << source_factory
      @it.target = 1.0
      source_factory.should_receive(:get_unit).with(:x).and_return(0.0)
      @it.get_unit(:x).should be_close(0.0, MARGIN)
    end
  end
  
end
