require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require "shared_factory_specs"
require 'rubyonacid/factories/skip'

include RubyOnAcid

describe SkipFactory do
  
  
  subject do
    SkipFactory.new
  end
  
  it_should_behave_like "a factory"
  
  it "generates only 0 or 1" do
    subject.odds = 0.1
    300.times do
      [0, 1].should include(subject.get_unit(:x))
    end
  end
  
  
end