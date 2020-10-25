require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "rubyonacid/factories/attraction"
require "shared_factory_specs"

include RubyOnAcid

describe AttractionFactory do

  subject do
    AttractionFactory.new
  end

  describe "general behavior" do
  
    before :each do
      subject.source_factories << double('Factory', :get_unit => 0.2)
      subject.attractor_factory = double('Factory', :get_unit => 0.3)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
      
    it "retrieves values from source factory and attracts them toward values from the attractor factory" do
      subject.source_factories << double('Factory', :get_unit => 0.0)
      subject.attractor_factory = double('Factory', :get_unit => 1.0)
      subject.get_unit(:x).should > 0.0
      subject.attractor_factory = double('Factory', :get_unit => 0.9)
      subject.get_unit(:x).should > 0.0
      subject.attractor_factory = double('Factory', :get_unit => 0.5)
      subject.get_unit(:x).should > 0.0
      subject.attractor_factory = double('Factory', :get_unit => 0.1)
      subject.get_unit(:x).should > 0.0
      subject.attractor_factory = double('Factory', :get_unit => 0.1)
      subject.get_unit(:x).should > 0.0
    end
    
    it "exerts greater attraction if values are closer" do
      pending
      subject.source_factories << double('Factory', :get_unit => 0.0)
      subject.attractor_factory = double('Factory')
      subject.attractor_factory.should_receive(:get_unit).and_return(1.0)
      distant_value = subject.get_unit(:x)
      subject.attractor_factory.should_receive(:get_unit).and_return(0.9)
      close_value = subject.get_unit(:x)
      close_value.should > distant_value
      distant_value = close_value
      subject.attractor_factory.should_receive(:get_unit).and_return(0.8)
      close_value = subject.get_unit(:x)
      close_value.should > distant_value
      distant_value = close_value
      subject.attractor_factory.should_receive(:get_unit).and_return(0.2)
      close_value = subject.get_unit(:x)
      close_value.should > distant_value
      distant_value = close_value
      subject.attractor_factory.should_receive(:get_unit).and_return(0.0)
      close_value = subject.get_unit(:x)
      close_value.should > distant_value
    end
    
    it "reduces source value if attractor's value is lower" do
      subject.source_factories << double('Factory', :get_unit => 0.9)
      subject.attractor_factory = double('Factory', :get_unit => 0.1)
      subject.get_unit(:x).should < 0.9
    end
    
  end
    
end
