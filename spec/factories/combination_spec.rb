require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "rubyonacid/factories/combination"
require "shared_factory_specs"

include RubyOnAcid

describe CombinationFactory do

  before :each do
    @it = CombinationFactory.new
  end

  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.source_factories << mock('Factory', :get_unit => 0.3)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
      
    it "retrieves values from source factories and adds them together" do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.source_factories << mock('Factory', :get_unit => 0.3)
      @it.get_unit(:x).should be_close(0.5, MARGIN)
      @it.source_factories << mock('Factory', :get_unit => 0.1)
      @it.get_unit(:x).should be_close(0.6, MARGIN)
    end
  
    it "can constrain sum to 0.0 through 1.0" do
      @it.constrain_mode = CombinationFactory::CONSTRAIN
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.source_factories << mock('Factory', :get_unit => 0.3)
      @it.source_factories << mock('Factory', :get_unit => 0.7)
      @it.get_unit(:x).should be_close(1.0, MARGIN)
    end
    
    it "uses wrap mode by default" do
      @it.source_factories << mock('Factory', :get_unit => 0.4)
      @it.source_factories << mock('Factory', :get_unit => 0.7)
      @it.get_unit(:x).should be_close(0.1, MARGIN)
    end
    
    it "can wrap > 1.0 value around" do
      @it.constrain_mode = CombinationFactory::WRAP
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.source_factories << mock('Factory', :get_unit => 0.3)
      @it.source_factories << mock('Factory', :get_unit => 0.7)
      @it.get_unit(:x).should be_close(0.2, MARGIN)
    end
    
    it "can make value 'rebound' off boundary" do
      @it.constrain_mode = CombinationFactory::REBOUND
      @it.source_factories = [
        mock('Factory', :get_unit => 0.4),
        mock('Factory', :get_unit => 0.7)
      ]
      @it.get_unit(:x).should be_close(0.9, MARGIN)
      @it.source_factories = [
        mock('Factory', :get_unit => 1.0),
        mock('Factory', :get_unit => 1.0),
        mock('Factory', :get_unit => 0.1)
      ]
      @it.get_unit(:x).should be_close(0.1, MARGIN)
      @it.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 0.1)
      ]
      @it.get_unit(:x).should be_close(0.2, MARGIN)
      @it.operation = CombinationFactory::SUBTRACT
      @it.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 0.4)
      ]
      @it.get_unit(:x).should be_close(0.3, MARGIN)
      @it.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 0.5),
        mock('Factory', :get_unit => 0.5)
      ]
      @it.get_unit(:x).should be_close(0.9, MARGIN)
      @it.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 1.0),
        mock('Factory', :get_unit => 1.0)
      ]
      @it.get_unit(:x).should be_close(0.1, MARGIN)
    end
    
  end
  
  describe "subtraction" do
    
    it "can subtract values from source factories" do
      @it.operation = CombinationFactory::SUBTRACT
      @it.source_factories << mock('Factory', :get_unit => 0.7)
      @it.source_factories << mock('Factory', :get_unit => 0.3)
      @it.get_unit(:x).should be_close(0.4, MARGIN)
      @it.source_factories << mock('Factory', :get_unit => 0.1)
      @it.get_unit(:x).should be_close(0.3, MARGIN)
    end
    
    it "can wrap < 0.0 value around" do
      @it.operation = CombinationFactory::SUBTRACT
      @it.constrain_mode = CombinationFactory::WRAP
      @it.source_factories << mock('Factory', :get_unit => 0.5)
      @it.source_factories << mock('Factory', :get_unit => 0.7)
      @it.get_unit(:x).should be_close(0.8, MARGIN)
    end
    
  end
  
  describe "multiplication" do
    it "can get product of values from source factories" do
      @it.operation = CombinationFactory::MULTIPLY
      @it.source_factories << mock('Factory', :get_unit => 0.7)
      @it.source_factories << mock('Factory', :get_unit => 0.5)
      @it.get_unit(:x).should be_close(0.35, MARGIN)
      @it.source_factories << mock('Factory', :get_unit => 0.1)
      @it.get_unit(:x).should be_close(0.035, MARGIN)
    end
  end
    
  describe "division" do
    it "can divide values from source factories" do
      @it.operation = CombinationFactory::DIVIDE
      @it.source_factories << mock('Factory', :get_unit => 0.1)
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.get_unit(:x).should be_close(0.5, MARGIN) #0.1 / 0.2 = 0.5
      @it.source_factories << mock('Factory', :get_unit => 0.9)
      @it.get_unit(:x).should be_close(0.555, MARGIN) #0.5 / 0.9 = 0.5555...
    end
  end
  
end
