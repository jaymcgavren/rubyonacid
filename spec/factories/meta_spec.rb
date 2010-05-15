require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/factories/meta'
require "shared_factory_specs"

include RubyOnAcid

describe MetaFactory do
  
  before :each do
    @it = MetaFactory.new
  end


  describe "general behavior" do
  
    before :each do
      @it.source_factories << mock('Factory', :get_unit => 0.2)
      @it.source_factories << mock('Factory', :get_unit => 0.1)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  
  it "takes a list of factories, then randomly and permanently assigns a factory to each requested key" do
    @it.source_factories << mock('FactoryZero', :get_unit => 0.0)
    @it.source_factories << mock('FactoryOne', :get_unit => 1.0)
    ('a'..'z').each do |key|
      @it.get_unit(key.to_sym).should == @it.get_unit(key.to_sym)
    end
  end
  
end
