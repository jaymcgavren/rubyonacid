require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'rubyonacid/factories/repeat'
require "shared_factory_specs"

include RubyOnAcid

describe RepeatFactory do
  
  describe "general behavior" do
  
    before :each do
      subject.source_factories << double('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  subject do
    RepeatFactory.new
  end
  
  it "Requests a value from the source factory and repeats it a given number of times" do
    source_factory = double('Factory')
    source_factory.should_receive(:get_unit).exactly(3).times.and_return(0.0, 1.0, 0.5)
    subject.source_factories << source_factory
    subject.repeat_count = 2
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 0.5
  end
  
  it "Tracks repeats on a per-key basis" do
    source_factory = double('Factory')
    source_factory.should_receive(:get_unit).exactly(4).times.and_return(0.0, 1.0, 0.5, 0.75)
    subject.source_factories << source_factory
    subject.repeat_count = 2
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:y).should == 1.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:y).should == 1.0
    subject.get_unit(:x).should == 0.5
    subject.get_unit(:y).should == 0.75
  end
  
end
