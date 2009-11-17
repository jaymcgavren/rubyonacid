require 'rubyonacid/factory'

module RubyOnAcid

class LoopFactory < Factory
  
  attr_accessor :interval
  def interval=(value)
    raise "assigned #{value} to interval, must be between -1 and 1" if value < -1 or value > 1
    @interval = value
  end
  
  def initialize(interval = 0.01)
    super
    @counters = {}
    @interval = interval
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