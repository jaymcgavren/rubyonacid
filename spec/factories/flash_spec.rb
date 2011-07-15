require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/flash'

include RubyOnAcid

describe FlashFactory do
  
  subject do
    FlashFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "returns 1.0 three times, then 0.0 three times, then loops" do
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 0.0
  end
  
  it "can take a different interval" do
    subject.interval = 2
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:x).should == 1.0
  end
  
  it "handles multiple keys" do
    subject.interval = 2
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:y).should == 1.0
    subject.get_unit(:x).should == 1.0
    subject.get_unit(:y).should == 1.0
    subject.get_unit(:x).should == 0.0
    subject.get_unit(:y).should == 0.0
  end
  
end