require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "rubyonacid/factories/queue"
require "shared_factory_specs"

include RubyOnAcid

describe QueueFactory do

  before :each do
    @it = QueueFactory.new
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
    
    it "retrieves multiple queue values in order" do
      @it.put(:x, 0.1)
      @it.put(:x, 0.2)
      @it.get(:x).should == 0.1
      @it.get(:x).should == 0.2
    end
    
    it "maps to a different key if the requested one isn't present" do
      @it.put(:x, 0.1)
      @it.get(:y).should == 0.1
    end
    
    it "returns 0 if a key is assigned but has no values" do
      @it.put(:x, 0.1)
      @it.put(:x, 0.2)
      @it.get(:y).should == 0.1
      @it.get(:y).should == 0.2
      @it.put(:z, 0.3)
      @it.get(:y).should == 0.0
    end
  
  end
  
  describe "scaling" do
    
    it "scales highest seen values for a key to 0 to 1 range" do
      @it.put(:x, 0.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_close(0.0, MARGIN)
      @it.get(:x).should be_close(1.0, MARGIN)
      @it.put(:x, 0.0)
      @it.put(:x, 1.0)
      @it.put(:x, 2.0)
      @it.get(:x).should be_close(0.0, MARGIN)
      @it.get(:x).should be_close(0.5, MARGIN)
      @it.get(:x).should be_close(1.0, MARGIN)
      @it.put(:x, 0.0)
      @it.put(:x, 3.0)
      @it.put(:x, 4.0)
      @it.get(:x).should be_close(0.0, MARGIN)
      @it.get(:x).should be_close(0.75, MARGIN)
      @it.get(:x).should be_close(1.0, MARGIN)
    end
    
    it "scales lowest seen values for a key to 0 to 1 range" do
      @it.put(:x, 0.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_close(0.0, MARGIN)
      @it.get(:x).should be_close(1.0, MARGIN)
      @it.put(:x, 0.0)
      @it.put(:x, 1.0)
      @it.put(:x, -2.0)
      @it.get(:x).should be_close(0.666, MARGIN)
      @it.get(:x).should be_close(1.0, MARGIN)
      @it.get(:x).should be_close(0.0, MARGIN)
      @it.put(:x, -2.0)
      @it.put(:x, 2.0)
      @it.put(:x, 1.0)
      @it.get(:x).should be_close(0.0, MARGIN)
      @it.get(:x).should be_close(1.0, MARGIN)
      @it.get(:x).should be_close(0.75, MARGIN)
    end
    
  end
  
end
