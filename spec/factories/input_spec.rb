require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "rubyonacid/factories/input"
require "shared_factory_specs"

include RubyOnAcid

describe InputFactory do

  subject do
    InputFactory.new
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
    
    it "stores only latest input value" do
      subject.put(:x, 0.1)
      subject.put(:x, 0.2)
      subject.get(:x).should == 0.2
    end
    
    it "maps to a different key if the requested one isn't present" do
      subject.put(:x, 0.1)
      subject.get(:y).should == 0.1
    end
    
    it "returns 0 if a key has no values" do
      subject.get(:z).should == 0.0
    end
  
    it "returns 0 only after mapping a different key" do
      subject.put(:x, 0.2)
      subject.get(:y).should == 0.2
      subject.get(:z).should == 0.0
    end
  
  end
  
  describe "scaling" do
    
    it "scales highest seen values for a key to 0 to 1 range" do
      subject.put(:x, 0.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 2.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(0.5)
      subject.put(:x, 0.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.put(:x, 4.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 3.0)
      subject.get(:x).should be_within(MARGIN).of(0.75)
      subject.put(:x, 0.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
    end
    
    it "scales lowest seen values for a key to 0 to 1 range" do
      subject.put(:x, 0.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, -2.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 0.0)
      subject.get(:x).should be_within(MARGIN).of(0.666)
      subject.put(:x, -2.0)
      subject.get(:x).should be_within(MARGIN).of(0.0)
      subject.put(:x, 2.0)
      subject.get(:x).should be_within(MARGIN).of(1.0)
      subject.put(:x, 1.0)
      subject.get(:x).should be_within(MARGIN).of(0.75)
    end
    
  end
  
end
