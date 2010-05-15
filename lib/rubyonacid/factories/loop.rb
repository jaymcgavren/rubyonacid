require 'rubyonacid/factory'

module RubyOnAcid

#Loops from the minimum value to the maximum and around again.
class LoopFactory < Factory
  
  #An amount between 0 and 1 to increment counters by.
  attr_accessor :interval
  def interval=(value)
    raise "assigned #{value} to interval, must be between -1 and 1" if value < -1 or value > 1
    @interval = value
  end
  
  def initialize(options = {})
    super
    @counters = {}
    @interval = options[:interval] || 0.01
  end
  
  #Increment counter for key, looping it around to opposite side if it exits boundary.
  def get_unit(key)
    @counters[key] ||= 0
    @counters[key] += @interval
    @counters[key] = @counters[key] - 1.0 if @counters[key] > 1
    @counters[key] = @counters[key] + 1.0 if @counters[key] < 0
    @counters[key]
  end

end

end