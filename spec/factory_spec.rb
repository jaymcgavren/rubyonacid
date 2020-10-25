require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/constant'

include RubyOnAcid

describe Factory do
  
  subject do
    Factory.new
  end
  
  describe "#choose" do
    
    it "chooses an item from a list" do
      expect(subject).to receive(:get_unit).and_return(0.0)
      subject.choose(:color, :red, :green, :blue).should == :red
      expect(subject).to receive(:get_unit).and_return(1.0)
      subject.choose(:color, :red, :green, :blue).should == :blue
      expect(subject).to receive(:get_unit).and_return(0.5)
      subject.choose(:color, :red, :green, :blue).should == :green
    end
    
    it "matches a range of values for each list item" do
      expect(subject).to receive(:get_unit).and_return(0.0)
      subject.choose(:foo, :a, :b, :c, :d).should == :a
      expect(subject).to receive(:get_unit).and_return(0.24)
      subject.choose(:foo, :a, :b, :c, :d).should == :a
      expect(subject).to receive(:get_unit).and_return(0.25)
      subject.choose(:foo, :a, :b, :c, :d).should == :b
      expect(subject).to receive(:get_unit).and_return(0.49)
      subject.choose(:foo, :a, :b, :c, :d).should == :b
      expect(subject).to receive(:get_unit).and_return(0.5)
      subject.choose(:foo, :a, :b, :c, :d).should == :c
      expect(subject).to receive(:get_unit).and_return(0.74)
      subject.choose(:foo, :a, :b, :c, :d).should == :c
      expect(subject).to receive(:get_unit).and_return(0.75)
      subject.choose(:foo, :a, :b, :c, :d).should == :d
      expect(subject).to receive(:get_unit).and_return(1.0)
      subject.choose(:foo, :a, :b, :c, :d).should == :d
    end
    
    it "accepts multiple arguments" do
      expect(subject).to receive(:get_unit).and_return(1.0)
      subject.choose(:color, :red, :green, :blue).should == :blue
    end
    
    it "accepts arrays" do
      expect(subject).to receive(:get_unit).and_return(1.0)
      subject.choose(:color, [:red, :green, :blue]).should == :blue
      expect(subject).to receive(:get_unit).and_return(1.0)
      subject.choose(:color, [:red, :green, :blue], [:yellow, :orange]).should == :orange
      expect(subject).to receive(:get_unit).and_return(0.0)
      subject.choose(:color, [:red, :green, :blue], [:yellow, :orange]).should == :red
    end
    
  end
  
  
  describe "#source_factories" do
    
    it "calls #get_unit on each and averages results" do
      factory1 = double('Factory')
      subject.source_factories << factory1
      factory2 = double('Factory')
      subject.source_factories << factory2
      factory3 = double('Factory')
      subject.source_factories << factory3
      factory1.should_receive(:get_unit).and_return(0.1)
      factory2.should_receive(:get_unit).and_return(0.2)
      factory3.should_receive(:get_unit).and_return(0.3)
      result = subject.get_unit(:x)
      result.should be_within(MARGIN).of(0.2)
    end
    
  end
  
  
end
