require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/sine'

include RubyOnAcid

describe SineFactory do
  
  
  subject do
    SineFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "loops between 0 and 1" do
    subject.interval = 1.0
    subject.get_unit(:x).should be_within(MARGIN).of(0.920)
    subject.get_unit(:x).should be_within(MARGIN).of(0.954)
    subject.get_unit(:x).should be_within(MARGIN).of(0.570)
    subject.get_unit(:x).should be_within(MARGIN).of(0.122)
    subject.get_unit(:x).should be_within(MARGIN).of(0.020)
    subject.get_unit(:x).should be_within(MARGIN).of(0.360)
  end
  
  it "can take a different interval" do
    subject.interval = 0.5
    subject.get_unit(:x).should be_within(MARGIN).of(0.740)
    subject.get_unit(:x).should be_within(MARGIN).of(0.920)
  end
  
  it "handles multiple keys" do
    subject.interval = 1.0
    subject.get_unit(:x).should be_within(MARGIN).of(0.920)
    subject.get_unit(:y).should be_within(MARGIN).of(0.920)
    subject.get_unit(:x).should be_within(MARGIN).of(0.954)
    subject.get_unit(:y).should be_within(MARGIN).of(0.954)
  end
  
end