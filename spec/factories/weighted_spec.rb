require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "rubyonacid/factories/weighted"
require "shared_factory_specs"

include RubyOnAcid

describe WeightedFactory do

  before :each do
    @it = WeightedFactory.new
  end

  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.source_factories << mock('Factory', :get_unit => 0.3)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
      
    it "gives factories with higher weights more influence" do
      factory1 = mock('Factory', :get_unit => 0.25)
      factory2 = mock('Factory', :get_unit => 0.75)
      @it.source_factories << factory1
      @it.source_factories << factory2
      @it.get_unit(:x).should be_close(0.5, MARGIN)
      @it.weights[factory1] = 1.0
      @it.weights[factory2] = 2.0
      @it.get_unit(:x).should > 0.5
    end
  
    it "multiplies factory values by weights when averaging" do
      factory1 = mock('Factory', :get_unit => 0.2)
      factory2 = mock('Factory', :get_unit => 0.4)
      @it.source_factories << factory1
      @it.source_factories << factory2
      @it.get_unit(:x).should be_close(0.3, MARGIN)
      @it.weights[factory1] = 2.0 #0.2 * 2.0 = 0.4
      @it.weights[factory2] = 4.0 #0.4 * 4.0 = 1.6
      #0.4 + 1.6 = 2.0
      #2.0 / 6.0 (total weight) = 0.333
      @it.get_unit(:x).should be_close(0.333, MARGIN)
    end
    
    it "can handle 3 or more factories" do
      factory1 = mock('Factory', :get_unit => 0.2)
      factory2 = mock('Factory', :get_unit => 0.4)
      factory3 = mock('Factory', :get_unit => 0.8)
      @it.source_factories << factory1
      @it.source_factories << factory2
      @it.source_factories << factory3
      @it.get_unit(:x).should be_close(0.4666, MARGIN)
      @it.weights[factory1] = 10.0 #0.2 * 10.0 = 2.0
      @it.weights[factory2] = 3.0 #0.4 * 3.0 = 1.2
      @it.weights[factory3] = 2.0 #0.8 * 2.0 = 1.6
      #2.0 + 1.2 + 1.6 = 4.8
      #puts 4.8 / 15.0 (total weight) = 0.32
      @it.get_unit(:x).should be_close(0.32, MARGIN)
    end
    
  end
  
  
end
