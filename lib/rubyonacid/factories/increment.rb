require 'rubyonacid/factory'

module RubyOnAcid

#Increments from the minimum value, stopping at the maximum, or decrements from the maximum value, stopping at the minimum.
class IncrementFactory < Factory

  #The amount to increment counters by.
  attr_accessor :interval
  def interval=(value)
    @interval = value
    @start_value = (@interval < 0.0 ? 1.0 : 0.0) 
    @counters.each_key{|k| @counters[k] = @start_value}
  end
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :interval => 0.001
  def initialize(options = {})
    super
    @start_value = 0.0
    @counters = {}
    @interval = options[:interval] || 0.001
  end
  
  #Increment counter for given key and return it. Constrain between 0 and 1.
  def get_unit(key)
    @counters[key] ||= @start_value
    @counters[key] += @interval
    @counters[key] = 1.0 if @counters[key] > 1.0
    @counters[key] = 0.0 if @counters[key] < 0.0
    @counters[key]
  end

end

end