require 'generator'

module RubyOnAcid

class FlashGenerator < Generator
  
  attr_accessor :interval
  
  def initialize
    @counters = Hash.new{|h,k| h[k] = 0}
    @values = Hash.new{|h,k| h[k] = 1.0}
    @interval = 3
  end
  
  #If key is over threshold, flip to other value and reset counter.
  def get(key)
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