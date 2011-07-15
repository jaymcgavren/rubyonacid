require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'rubyonacid/factories/rounding'
require "shared_factory_specs"

include RubyOnAcid

describe RoundingFactory do
  
  subject do
    RoundingFactory.new
  end

  describe "general behavior" do
  
    before :each do
      subject.source_factories << mock('Factory', :get_unit => 0.2)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  it "Requests a value from the source factory and rounds it to a multiple of the requested number" do
    source_factory = mock('Factory')
    subject.source_factories << source_factory
    subject.nearest = 0.3
    source_factory.should_receive(:get_unit).and_return(0.7)
    subject.get_unit(:x).should be_within(MARGIN).of(0.6)
    source_factory.should_receive(:get_unit).and_return(0.8)
    subject.get_unit(:x).should be_within(MARGIN).of(0.9)
    source_factory.should_receive(:get_unit).and_return(0.9)
    subject.get_unit(:x).should be_within(MARGIN).of(0.9)
    source_factory.should_receive(:get_unit).and_return(1.0)
    subject.get_unit(:x).should be_within(MARGIN).of(0.9)
  end
  
  it "can round to multiples of 0.2" do
    source_factory = mock('Factory')
    subject.source_factories << source_factory
    subject.nearest = 0.2
    source_factory.should_receive(:get_unit).and_return(0.0)
    subject.get_unit(:x).should be_within(MARGIN).of(0.0)
    source_factory.should_receive(:get_unit).and_return(0.11)
    subject.get_unit(:x).should be_within(MARGIN).of(0.2)
    source_factory.should_receive(:get_unit).and_return(0.2)
    subject.get_unit(:x).should be_within(MARGIN).of(0.2)
    source_factory.should_receive(:get_unit).and_return(0.31)
    subject.get_unit(:x).should be_within(MARGIN).of(0.4)
    source_factory.should_receive(:get_unit).and_return(0.4)
    subject.get_unit(:x).should be_within(MARGIN).of(0.4)
  end
  
  it "can round to multiples of 1.0" do
    source_factory = mock('Factory')
    subject.source_factories << source_factory
    subject.nearest = 1.0
    source_factory.should_receive(:get_unit).and_return(0.0)
    subject.get_unit(:x).should be_within(MARGIN).of(0.0)
    source_factory.should_receive(:get_unit).and_return(0.4)
    subject.get_unit(:x).should be_within(MARGIN).of(0.0)
    source_factory.should_receive(:get_unit).and_return(0.51)
    subject.get_unit(:x).should be_within(MARGIN).of(1.0)
    source_factory.should_receive(:get_unit).and_return(0.9)
    subject.get_unit(:x).should be_within(MARGIN).of(1.0)
    source_factory.should_receive(:get_unit).and_return(1.0)
    subject.get_unit(:x).should be_within(MARGIN).of(1.0)
  end
  
end
