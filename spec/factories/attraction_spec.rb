require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "rubyonacid/factories/attraction"
require "shared_factory_specs"

include RubyOnAcid

describe AttractionFactory do

  before :each do
    @it = AttractionFactory.new
  end

  describe "general behavior" do
  
    before :each do
      @it.source_factory = mock('Factory', :get_unit => 0.2)
      @it.attractor_factory = mock('Factory', :get_unit => 0.3)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
      
    it "retrieves values from source factory and attracts them toward values from the attractor factory" do
      @it.source_factory = mock('Factory', :get_unit => 0.0)
      @it.attractor_factory = mock('Factory', :get_unit => 1.0)
      @it.get_unit(:x).should > 0.0
    end
  
    it "exerts greater attraction if values are closer" do
      @it.source_factory = mock('Factory', :get_unit => 0.0)
      @it.attractor_factory = mock('Factory')
      @it.attractor_factory.should_receive(:get_unit).and_return(1.0)
      distant_value = @it.get_unit(:x)
      @it.attractor_factory.should_receive(:get_unit).and_return(0.5)
      close_value = @it.get_unit(:x)
      close_value.should > distant_value
    end
    
    it "reduces source value if attractor's value is lower" do
      @it.source_factory = mock('Factory', :get_unit => 0.9)
      @it.attractor_factory = mock('Factory', :get_unit => 0.1)
      @it.get_unit(:x).should < 0.9
    end
    
  end
    
end
