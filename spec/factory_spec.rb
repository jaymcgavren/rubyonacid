require File.join(File.dirname(__FILE__), 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/constant'

include RubyOnAcid

describe Factory do
  
  before :each do
    @it = Factory.new
  end
  
  describe "#choose" do
    
    it "chooses an item from a list" do
      @it.stub!(:get_unit).and_return(0.0)
      @it.choose(:color, :red, :green, :blue).should == :red
      @it.stub!(:get_unit).and_return(1.0)
      @it.choose(:color, :red, :green, :blue).should == :blue
      @it.stub!(:get_unit).and_return(0.5)
      @it.choose(:color, :red, :green, :blue).should == :green
    end
    
    it "matches a range of values for each list item" do
      @it.stub!(:get_unit).and_return(0.0)
      @it.choose(:foo, :a, :b, :c, :d).should == :a
      @it.stub!(:get_unit).and_return(0.24)
      @it.choose(:foo, :a, :b, :c, :d).should == :a
      @it.stub!(:get_unit).and_return(0.25)
      @it.choose(:foo, :a, :b, :c, :d).should == :b
      @it.stub!(:get_unit).and_return(0.49)
      @it.choose(:foo, :a, :b, :c, :d).should == :b
      @it.stub!(:get_unit).and_return(0.5)
      @it.choose(:foo, :a, :b, :c, :d).should == :c
      @it.stub!(:get_unit).and_return(0.74)
      @it.choose(:foo, :a, :b, :c, :d).should == :c
      @it.stub!(:get_unit).and_return(0.75)
      @it.choose(:foo, :a, :b, :c, :d).should == :d
      @it.stub!(:get_unit).and_return(1.0)
      @it.choose(:foo, :a, :b, :c, :d).should == :d
    end
    
    it "accepts multiple arguments" do
      @it.stub!(:get_unit).and_return(1.0)
      @it.choose(:color, :red, :green, :blue).should == :blue
    end
    
    it "accepts arrays" do
      @it.stub!(:get_unit).and_return(1.0)
      @it.choose(:color, [:red, :green, :blue]).should == :blue
      @it.stub!(:get_unit).and_return(1.0)
      @it.choose(:color, [:red, :green, :blue], [:yellow, :orange]).should == :orange
      @it.stub!(:get_unit).and_return(0.0)
      @it.choose(:color, [:red, :green, :blue], [:yellow, :orange]).should == :red
    end
    
  end
  
  
  describe "#source_factories" do
    
    it "calls #get_unit on each and averages results" do
      factory1 = mock('Factory')
      @it.source_factories << factory1
      factory2 = mock('Factory')
      @it.source_factories << factory2
      factory3 = mock('Factory')
      @it.source_factories << factory3
      factory1.should_receive(:get_unit).and_return(0.1)
      factory2.should_receive(:get_unit).and_return(0.2)
      factory3.should_receive(:get_unit).and_return(0.3)
      result = @it.get_unit(:x)
      result.should be_close(0.2, MARGIN)
    end
    
  end
  
  
end