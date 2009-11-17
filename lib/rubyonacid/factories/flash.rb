require 'rubyonacid/factory'

module RubyOnAcid

class FlashFactory < Factory
  
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