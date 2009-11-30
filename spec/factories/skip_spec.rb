require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_factory_specs"
require 'rubyonacid/factories/skip'

include RubyOnAcid

describe SkipFactory do
  
  MARGIN = 0.01
  
  before :each do
    @it = SkipFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "generates only 0 or 1" do
    @it.odds = 0.1
    300.times do
      [0, 1].should include(@it.get_unit(:x))
    end
  end
  
  
end