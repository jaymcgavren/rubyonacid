require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "rubyonacid/factories/weighted"
require "shared_factory_specs"

include RubyOnAcid

describe WeightedFactory do

  subject do
    WeightedFactory.new
  end

  describe "general behavior" do
  
    before :each do
      subject.source_factories << double('Factory', :get_unit => 0.2)
      subject.source_factories << double('Factory', :get_unit => 0.3)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  describe "#get_unit" do
      
    it "gives factories with higher weights more influence" do
      factory1 = double('Factory', :get_unit => 0.25)
      factory2 = double('Factory', :get_unit => 0.75)
      subject.source_factories << factory1
      subject.source_factories << factory2
      subject.get_unit(:x).should be_within(MARGIN).of(0.5)
      subject.weights[factory1] = 1.0
      subject.weights[factory2] = 2.0
      subject.get_unit(:x).should > 0.5
    end
  
    it "multiplies factory values by weights when averaging" do
      factory1 = double('Factory', :get_unit => 0.2)
      factory2 = double('Factory', :get_unit => 0.4)
      subject.source_factories << factory1
      subject.source_factories << factory2
      subject.get_unit(:x).should be_within(MARGIN).of(0.3)
      subject.weights[factory1] = 2.0 #0.2 * 2.0 = 0.4
      subject.weights[factory2] = 4.0 #0.4 * 4.0 = 1.6
      #0.4 + 1.6 = 2.0
      #2.0 / 6.0 (total weight) = 0.333
      subject.get_unit(:x).should be_within(MARGIN).of(0.333)
    end
    
    it "can handle 3 or more factories" do
      factory1 = double('Factory', :get_unit => 0.2)
      factory2 = double('Factory', :get_unit => 0.4)
      factory3 = double('Factory', :get_unit => 0.8)
      subject.source_factories << factory1
      subject.source_factories << factory2
      subject.source_factories << factory3
      subject.get_unit(:x).should be_within(MARGIN).of(0.4666)
      subject.weights[factory1] = 10.0 #0.2 * 10.0 = 2.0
      subject.weights[factory2] = 3.0 #0.4 * 3.0 = 1.2
      subject.weights[factory3] = 2.0 #0.8 * 2.0 = 1.6
      #2.0 + 1.2 + 1.6 = 4.8
      #puts 4.8 / 15.0 (total weight) = 0.32
      subject.get_unit(:x).should be_within(MARGIN).of(0.32)
    end
    
  end
  
  
end
