require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/generators/meta'

include RubyOnAcid

describe MetaGenerator do
  
  before :each do
    @it = MetaGenerator.new
  end
  
  it "takes a list of generators, then randomly and permanently assigns a generator to each requested key" do
    @it.generators << mock('GeneratorZero', :get_unit => 0.0)
    @it.generators << mock('GeneratorOne', :get_unit => 1.0)
    ('a'..'z').each do |key|
      @it.get_unit(key.to_sym).should == @it.get_unit(key.to_sym)
    end
  end
  
end
