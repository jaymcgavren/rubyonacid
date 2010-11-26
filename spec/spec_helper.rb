$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'rspec'
require 'rspec/autorun'

#Allowed margin of error for be_close.
MARGIN = 0.01

Spec::Runner.configure do |config|
  
end
