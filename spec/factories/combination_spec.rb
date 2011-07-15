require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "rubyonacid/factories/combination"
require "shared_factory_specs"

include RubyOnAcid

describe CombinationFactory do

  subject do
    CombinationFactory.new
  end

  describe "general behavior" do
  
    before :each do
      subject.source_factories << mock('Factory', :get_unit => 0.2)
      subject.source_factories << mock('Factory', :get_unit => 0.3)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
      
    it "retrieves values from source factories and adds them together" do
      subject.source_factories << mock('Factory', :get_unit => 0.2)
      subject.source_factories << mock('Factory', :get_unit => 0.3)
      subject.get_unit(:x).should be_within(MARGIN).of(0.5)
      subject.source_factories << mock('Factory', :get_unit => 0.1)
      subject.get_unit(:x).should be_within(MARGIN).of(0.6)
    end
  
    it "can constrain sum to 0.0 through 1.0" do
      subject.constrain_mode = CombinationFactory::CONSTRAIN
      subject.source_factories << mock('Factory', :get_unit => 0.2)
      subject.source_factories << mock('Factory', :get_unit => 0.3)
      subject.source_factories << mock('Factory', :get_unit => 0.7)
      subject.get_unit(:x).should be_within(MARGIN).of(1.0)
    end
    
    it "uses wrap mode by default" do
      subject.source_factories << mock('Factory', :get_unit => 0.4)
      subject.source_factories << mock('Factory', :get_unit => 0.7)
      subject.get_unit(:x).should be_within(MARGIN).of(0.1)
    end
    
    it "can wrap > 1.0 value around" do
      subject.constrain_mode = CombinationFactory::WRAP
      subject.source_factories << mock('Factory', :get_unit => 0.2)
      subject.source_factories << mock('Factory', :get_unit => 0.3)
      subject.source_factories << mock('Factory', :get_unit => 0.7)
      subject.get_unit(:x).should be_within(MARGIN).of(0.2)
    end
    
    it "can make value 'rebound' off boundary" do
      subject.constrain_mode = CombinationFactory::REBOUND
      subject.source_factories = [
        mock('Factory', :get_unit => 0.4),
        mock('Factory', :get_unit => 0.7)
      ]
      subject.get_unit(:x).should be_within(MARGIN).of(0.9)
      subject.source_factories = [
        mock('Factory', :get_unit => 1.0),
        mock('Factory', :get_unit => 1.0),
        mock('Factory', :get_unit => 0.1)
      ]
      subject.get_unit(:x).should be_within(MARGIN).of(0.1)
      subject.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 0.1)
      ]
      subject.get_unit(:x).should be_within(MARGIN).of(0.2)
      subject.operation = CombinationFactory::SUBTRACT
      subject.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 0.4)
      ]
      subject.get_unit(:x).should be_within(MARGIN).of(0.3)
      subject.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 0.5),
        mock('Factory', :get_unit => 0.5)
      ]
      subject.get_unit(:x).should be_within(MARGIN).of(0.9)
      subject.source_factories = [
        mock('Factory', :get_unit => 0.1),
        mock('Factory', :get_unit => 1.0),
        mock('Factory', :get_unit => 1.0)
      ]
      subject.get_unit(:x).should be_within(MARGIN).of(0.1)
    end
    
  end
  
  describe "subtraction" do
    
    it "can subtract values from source factories" do
      subject.operation = CombinationFactory::SUBTRACT
      subject.source_factories << mock('Factory', :get_unit => 0.7)
      subject.source_factories << mock('Factory', :get_unit => 0.3)
      subject.get_unit(:x).should be_within(MARGIN).of(0.4)
      subject.source_factories << mock('Factory', :get_unit => 0.1)
      subject.get_unit(:x).should be_within(MARGIN).of(0.3)
    end
    
    it "can wrap < 0.0 value around" do
      subject.operation = CombinationFactory::SUBTRACT
      subject.constrain_mode = CombinationFactory::WRAP
      subject.source_factories << mock('Factory', :get_unit => 0.5)
      subject.source_factories << mock('Factory', :get_unit => 0.7)
      subject.get_unit(:x).should be_within(MARGIN).of(0.8)
    end
    
  end
  
  describe "multiplication" do
    it "can get product of values from source factories" do
      subject.operation = CombinationFactory::MULTIPLY
      subject.source_factories << mock('Factory', :get_unit => 0.7)
      subject.source_factories << mock('Factory', :get_unit => 0.5)
      subject.get_unit(:x).should be_within(MARGIN).of(0.35)
      subject.source_factories << mock('Factory', :get_unit => 0.1)
      subject.get_unit(:x).should be_within(MARGIN).of(0.035)
    end
  end
    
  describe "division" do
    it "can divide values from source factories" do
      subject.operation = CombinationFactory::DIVIDE
      subject.source_factories << mock('Factory', :get_unit => 0.1)
      subject.source_factories << mock('Factory', :get_unit => 0.2)
      subject.get_unit(:x).should be_within(MARGIN).of(0.5) #0.1 / 0.2 = 0.5
      subject.source_factories << mock('Factory', :get_unit => 0.9)
      subject.get_unit(:x).should be_within(MARGIN).of(0.555) #0.5 / 0.9 = 0.5555...
    end
  end
  
end
