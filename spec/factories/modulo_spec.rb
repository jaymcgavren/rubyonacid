require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/factories/modulo'

include RubyOnAcid

describe ModuloFactory do
  
  MARGIN = 0.01
  
  before :each do
    @it = ModuloFactory.new
  end
  
  it "accumulates values and returns remainder of dividing by 1" do
    source_factory = mock('Factory')
    source_factory.should_receive(:get_unit).exactly(3).times.and_return(0.1, 0.35, 0.75)
    @it.source_factory = source_factory
    @it.get_unit(:x).should be_close(0.1, MARGIN)
    @it.get_unit(:x).should be_close(0.45, MARGIN)
    @it.get_unit(:x).should be_close(0.2, MARGIN) #0.45 + 0.75 == 1.2, 1.2 modulo 1 == 0.2
  end
  
  it "Tracks modulos on a per-key basis" do
    source_factory = mock('Factory')
    source_factory.should_receive(:get_unit).exactly(4).times.and_return(0.25, 0.9, 0.33, 0.8)
    @it.source_factory = source_factory
    @it.get_unit(:x).should be_close(0.25, MARGIN)#== 0.25
    @it.get_unit(:x).should be_close(0.15, MARGIN)#== 0.15
    @it.get_unit(:y).should be_close(0.33, MARGIN)#== 0.33
    @it.get_unit(:x).should be_close(0.95, MARGIN)#== 0.95
  end
  
end
