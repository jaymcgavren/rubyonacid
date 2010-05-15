require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/factories/rounding'
require "shared_factory_specs"

include RubyOnAcid

describe RoundingFactory do
  
  before :each do
    @it = RoundingFactory.new
  end

  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  it "Requests a value from the source factory and rounds it to a multiple of the requested number" do
    source_factory = mock('Factory')
    @it.source_factories << source_factory
    @it.nearest = 0.3
    source_factory.should_receive(:get_unit).and_return(0.7)
    @it.get_unit(:x).should be_close(0.6, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.8)
    @it.get_unit(:x).should be_close(0.9, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.9)
    @it.get_unit(:x).should be_close(0.9, MARGIN)
    source_factory.should_receive(:get_unit).and_return(1.0)
    @it.get_unit(:x).should be_close(0.9, MARGIN)
  end
  
  it "can round to multiples of 0.2" do
    source_factory = mock('Factory')
    @it.source_factories << source_factory
    @it.nearest = 0.2
    source_factory.should_receive(:get_unit).and_return(0.0)
    @it.get_unit(:x).should be_close(0.0, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.11)
    @it.get_unit(:x).should be_close(0.2, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.2)
    @it.get_unit(:x).should be_close(0.2, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.31)
    @it.get_unit(:x).should be_close(0.4, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.4)
    @it.get_unit(:x).should be_close(0.4, MARGIN)
  end
  
  it "can round to multiples of 1.0" do
    source_factory = mock('Factory')
    @it.source_factories << source_factory
    @it.nearest = 1.0
    source_factory.should_receive(:get_unit).and_return(0.0)
    @it.get_unit(:x).should be_close(0.0, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.4)
    @it.get_unit(:x).should be_close(0.0, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.51)
    @it.get_unit(:x).should be_close(1.0, MARGIN)
    source_factory.should_receive(:get_unit).and_return(0.9)
    @it.get_unit(:x).should be_close(1.0, MARGIN)
    source_factory.should_receive(:get_unit).and_return(1.0)
    @it.get_unit(:x).should be_close(1.0, MARGIN)
  end
  
end
