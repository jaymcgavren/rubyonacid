require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "rubyonacid/factories/input"
require "shared_factory_specs"

include RubyOnAcid

describe InputFactory do

  before :each do
    @it = InputFactory.new
  end

  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
    
    it "retrieves values assigned to a key" do
      @it.put(:x, 0.1)
      @it.get(:x).should == 0.1
    end
    
    it "stores only latest input value" do
      @it.put(:x, 0.1)
      @it.put(:x, 0.2)
      @it.get(:x).should == 0.2
    end
    
    it "maps to a different key if the requested one isn't present" do
      @it.put(:x, 0.1)
      @it.get(:y).should == 0.1
    end
    
    it "returns 0 if a key has no values" do
      @it.get(:z).should == 0.0
    end
  
    it "returns 0 only after mapping a different key" do
      @it.put(:x, 0.2)
      @it.get(:y).should == 0.2
      @it.get(:z).should == 0.0
    end
  
  end
  
  describe "scaling" do
    
    it "scales highest seen values for a key to 0 to 1 range" do
      @it.put(:x, 0.0)
      @it.get(:x).should be_within(MARGIN).of(0.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_within(MARGIN).of(1.0)
      @it.put(:x, 2.0)
      @it.get(:x).should be_within(MARGIN).of(1.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_within(MARGIN).of(0.5)
      @it.put(:x, 0.0)
      @it.get(:x).should be_within(MARGIN).of(0.0)
      @it.put(:x, 4.0)
      @it.get(:x).should be_within(MARGIN).of(1.0)
      @it.put(:x, 3.0)
      @it.get(:x).should be_within(MARGIN).of(0.75)
      @it.put(:x, 0.0)
      @it.get(:x).should be_within(MARGIN).of(0.0)
    end
    
    it "scales lowest seen values for a key to 0 to 1 range" do
      @it.put(:x, 0.0)
      @it.get(:x).should be_within(MARGIN).of(0.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_within(MARGIN).of(1.0)
      @it.put(:x, -2.0)
      @it.get(:x).should be_within(MARGIN).of(0.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_within(MARGIN).of(1.0)
      @it.put(:x, 0.0)
      @it.get(:x).should be_within(MARGIN).of(0.666)
      @it.put(:x, -2.0)
      @it.get(:x).should be_within(MARGIN).of(0.0)
      @it.put(:x, 2.0)
      @it.get(:x).should be_within(MARGIN).of(1.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_within(MARGIN).of(0.75)
    end
    
  end
  
end
