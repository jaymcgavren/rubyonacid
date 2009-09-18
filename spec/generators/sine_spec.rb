require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require 'generators/sine'

describe RubyOnAcid::SineGenerator do
  
  MARGIN = 0.01
  
  before :each do
    @it = RubyOnAcid::SineGenerator.new
  end
  
  it_should_behave_like "a generator"
  
  it "loops between 0 and 1" do
    @it.interval = 1.0
    # @it.get(:x).should be_close(0.500, MARGIN)
    @it.get(:x).should be_close(0.920, MARGIN)
    @it.get(:x).should be_close(0.954, MARGIN)
    @it.get(:x).should be_close(0.570, MARGIN)
    @it.get(:x).should be_close(0.122, MARGIN)
    @it.get(:x).should be_close(0.020, MARGIN)
    @it.get(:x).should be_close(0.360, MARGIN)
  end
  
  it "can take a different interval" do
    @it.interval = 0.5
    # @it.get(:x).should be_close(0.500, MARGIN)
    @it.get(:x).should be_close(0.740, MARGIN)
    @it.get(:x).should be_close(0.920, MARGIN)
  end
  
  it "handles multiple keys" do
    @it.interval = 1.0
    @it.get(:x).should be_close(0.920, MARGIN)
    @it.get(:y).should be_close(0.920, MARGIN)
    @it.get(:x).should be_close(0.954, MARGIN)
    @it.get(:y).should be_close(0.954, MARGIN)
  end
  
end