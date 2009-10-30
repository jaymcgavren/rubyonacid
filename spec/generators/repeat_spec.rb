require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/factories/repeat'

include RubyOnAcid

describe RepeatFactory do
  
  before :each do
    @it = RepeatFactory.new
  end
  
  it "Requests a value from the source factory and repeats it a given number of times" do
    source_factory = mock('Factory')
    source_factory.should_receive(:get_unit).exactly(3).times.and_return(0.0, 1.0, 0.5)
    @it.source_factory = source_factory
    @it.repeat_count = 2
    @it.get_unit(:x).should == 0.0
    @it.get_unit(:x).should == 0.0
    @it.get_unit(:x).should == 1.0
    @it.get_unit(:x).should == 1.0
    @it.get_unit(:x).should == 0.5
  end
  
  it "Tracks repeats on a per-key basis" do
    source_factory = mock('Factory')
    source_factory.should_receive(:get_unit).exactly(4).times.and_return(0.0, 1.0, 0.5, 0.75)
    @it.source_factory = source_factory
    @it.repeat_count = 2
    @it.get_unit(:x).should == 0.0
    @it.get_unit(:y).should == 1.0
    @it.get_unit(:x).should == 0.0
    @it.get_unit(:y).should == 1.0
    @it.get_unit(:x).should == 0.5
    @it.get_unit(:y).should == 0.75
  end
  
end
