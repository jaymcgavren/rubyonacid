require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require "shared_generator_specs"
require 'generators/skip'

describe RubyOnAcid::SkipGenerator do
  
  MARGIN = 0.01
  
  before :each do
    @it = RubyOnAcid::SkipGenerator.new
  end
  
  it_should_behave_like "a generator"
  
  it "generates only 0 or 1" do
    @it.odds = 0.1
    300.times do
      [0, 1].should include(@it.get(:x))
    end
  end
  
  
end