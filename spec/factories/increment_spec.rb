require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/increment'

include RubyOnAcid

describe IncrementFactory do
  
  
  subject do
    IncrementFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "Stops at 1 if increment is positive" do
    subject.interval = 0.3
    subject.get_unit(:x).should be_within(MARGIN).of(0.3)
    subject.get_unit(:x).should be_within(MARGIN).of(0.6)
    subject.get_unit(:x).should be_within(MARGIN).of(0.9)
    subject.get_unit(:x).should be_within(MARGIN).of(1.0)
    subject.get_unit(:x).should be_within(MARGIN).of(1.0)
  end
  
  it "Stops at 0 if increment is negative" do
    subject.interval = -0.3
    subject.get_unit(:x).should be_within(MARGIN).of(0.7)
    subject.get_unit(:x).should be_within(MARGIN).of(0.4)
    subject.get_unit(:x).should be_within(MARGIN).of(0.1)
    subject.get_unit(:x).should be_within(MARGIN).of(0.0)
    subject.get_unit(:x).should be_within(MARGIN).of(0.0)
  end
  
  it "handles multiple keys" do
    subject.interval = 0.3
    subject.get_unit(:x).should be_within(MARGIN).of(0.3)
    subject.get_unit(:y).should be_within(MARGIN).of(0.3)
    subject.get_unit(:x).should be_within(MARGIN).of(0.6)
    subject.get_unit(:y).should be_within(MARGIN).of(0.6)
  end
  
end