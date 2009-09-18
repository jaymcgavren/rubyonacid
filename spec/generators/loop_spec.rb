require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require 'generators/loop'

describe RubyOnAcid::LoopGenerator do
  
  MARGIN = 0.01
  
  before :each do
    @it = RubyOnAcid::LoopGenerator.new
  end
  
  it_should_behave_like "a generator"
  
  it "Loops to 0 if increment is positive" do
    @it.interval = 0.3
    @it.get(:x).should be_close(0.3, MARGIN)
    @it.get(:x).should be_close(0.6, MARGIN)
    @it.get(:x).should be_close(0.9, MARGIN)
    @it.get(:x).should be_close(0.2, MARGIN)
    @it.get(:x).should be_close(0.5, MARGIN)
  end
  
  it "Loops to 1 if increment is negative" do
    @it.interval = -0.3
    @it.get(:x).should be_close(0.7, MARGIN)
    @it.get(:x).should be_close(0.4, MARGIN)
    @it.get(:x).should be_close(0.1, MARGIN)
    @it.get(:x).should be_close(0.8, MARGIN)
    @it.get(:x).should be_close(0.5, MARGIN)
  end
  
  it "handles multiple keys" do
    @it.interval = 0.3
    @it.get(:x).should be_close(0.3, MARGIN)
    @it.get(:y).should be_close(0.3, MARGIN)
    @it.get(:x).should be_close(0.6, MARGIN)
    @it.get(:y).should be_close(0.6, MARGIN)
  end
  
end