require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "rubyonacid/factories/queue"
require "shared_factory_specs"

include RubyOnAcid

describe QueueFactory do

  subject do
    QueueFactory.new
  end

  describe "general behavior" do
  
    before :each do
      subject.source_factories << double('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
    
    it "retrieves values assigned to a key" do
      subject.put(:x, 0.1)
      subject.get(:x).should == 0.1
    end
    
    it "retrieves multiple queue values in order" do
      subject.put(:x, 0.1)
      subject.put(:x, 0.2)
      subject.get(:x).should == 0.1
      subject.get(:x).should == 0.2
    end
    
    it "maps to a different key if the requested one isn't present" do
      subject.put(:x, 0.1)
      subject.get(:y).should == 0.1
    end
    
    it "returns 0 if a key is assigned but has no values" do
      subject.put(:x, 0.1)
      subject.put(:x, 0.2)
      subject.get(:y).should == 0.1
      subject.get(:y).should == 0.2
      subject.put(:z, 0.3)
      subject.get(:y).should == 0.0
    end
  
  end
  
  describe "scaling" do
    
    it "scales highest seen values for a key to 0 to 1 range" do
      subject.put(:x, 0.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 0.0)
      subject.put(:x, 1.0)
      subject.put(:x, 2.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.get(:x).should be_within(MARGIN).of(0.5)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 0.0)
      subject.put(:x, 3.0)
      subject.put(:x, 4.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.get(:x).should be_within(MARGIN).of(0.75)
      subject.get(:x).should be_within(MARGIN).of(1.0)
    end
    
    it "scales lowest seen values for a key to 0 to 1 range" do
      subject.put(:x, 0.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 0.0)
      subject.put(:x, 1.0)
      subject.put(:x, -2.0)
      subject.get(:x).should be_within(MARGIN).of(0.666)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.put(:x, -2.0)
      subject.put(:x, 2.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.get(:x).should be_within(MARGIN).of(0.75)
    end
    
  end
  
end
