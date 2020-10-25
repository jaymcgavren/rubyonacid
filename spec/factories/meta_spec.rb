require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'rubyonacid/factories/meta'
require "shared_factory_specs"

include RubyOnAcid

describe MetaFactory do
  
  subject do
    MetaFactory.new
  end


  describe "general behavior" do
  
    before :each do
      subject.source_factories << double('Factory', :get_unit => 0.2)
      subject.source_factories << double('Factory', :get_unit => 0.1)
    end
  
    it_should_behave_like "a factory"
    
  end
  
  
  it "takes a list of factories, then randomly and permanently assigns a factory to each requested key" do
    subject.source_factories << double('FactoryZero', :get_unit => 0.0)
    subject.source_factories << double('FactoryOne', :get_unit => 1.0)
    ('a'..'z').each do |key|
      subject.get_unit(key.to_sym).should == subject.get_unit(key.to_sym)
    end
  end
  
end
