require 'rubyonacid/factory'

module RubyOnAcid

#Returns 0.0 for a given number of queries, then 1.0 for the same number of queries, then goes back to 0.0 and repeats.
class FlashFactory < Factory
  
  #The number of times to return a value before switching.
  attr_accessor :interval
  
  def initialize(interval = 3)
    super
    @counters = {}
    @values = {}
    @interval = interval
  end
  
  #If key is over threshold, flip to other value and reset counter.
  def get_unit(key)
    @counters[key] ||= 0
    @values[key] ||= 1.0
    if @counters[key] >= @interval
      @values[key] = (@values[key] == 1.0 ? 0.0 : 1.0)
      @counters[key] = 0
    end
    #Increment counter.
    @counters[key] += 1
    #Return value.
    @values[key]
  end

end

end