require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rubyonacid/factories/meta'

include RubyOnAcid

describe MetaFactory do
  
  before :each do
    @it = MetaFactory.new
  end
  
  it "takes a list of factories, then randomly and permanently assigns a factory to each requested key" do
    @it.factories << mock('FactoryZero', :get_unit => 0.0)
    @it.factories << mock('FactoryOne', :get_unit => 1.0)
    ('a'..'z').each do |key|
      @it.get_unit(key.to_sym).should == @it.get_unit(key.to_sym)
    end
  end
  
end
