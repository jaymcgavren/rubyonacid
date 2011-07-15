require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'rubyonacid/factories/proximity'
require "shared_factory_specs"

include RubyOnAcid

describe ProximityFactory do
  
  subject do
    ProximityFactory.new
  end

  describe "general behavior" do
  
    before :each do
      subject.source_factories << mock('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
    it "requests value from the source factory and scales it based on its proximity to the target value" do
      source_factory = mock('Factory')
      subject.source_factories << source_factory
      subject.target = 0.5
      source_factory.should_receive(:get_unit).with(:x).and_return(0.5)
      near_value = subject.get_unit(:x)
      source_factory.should_receive(:get_unit).with(:x).and_return(0.7)
      far_value = subject.get_unit(:x)
      near_value.should > far_value
    end
    
    it "should return 1.0 if source value matches target exactly" do
      source_factory = mock('Factory')
      subject.source_factories << source_factory
      subject.target = 0.5
      source_factory.should_receive(:get_unit).with(:x).and_return(0.5)
      subject.get_unit(:x).should be_within(MARGIN).of(1.0)
    end
    
    it "should approach zero as distance approaches 1.0" do
      source_factory = mock('Factory')
      subject.source_factories << source_factory
      subject.target = 1.0
      source_factory.should_receive(:get_unit).with(:x).and_return(0.0)
      subject.get_unit(:x).should be_within(MARGIN).of(0.0)
    end
  end
  
end
