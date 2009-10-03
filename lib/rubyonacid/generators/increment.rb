require 'generator'

module RubyOnAcid

class IncrementGenerator < Generator
  
  attr_accessor :interval
  def interval=(value)
    @interval = value
    @start_value = (@interval < 0.0 ? 1.0 : 0.0) 
    @counters.each_key{|k| @counters[k] = @start_value}
  end
  
  def initialize
    @start_value = 0.0
    @counters = Hash.new{|h,k| h[k] = @start_value}
    @interval = 0.0001
  end
  
  #Increment counter for key and get its sine, then scale it between 0 and 1.
  def get_unit(key)
    @counters[key] += @interval
    @counters[key] = 1.0 if @counters[key] > 1.0
    @counters[key] = 0.0 if @counters[key] < 0.0
    @counters[key]
  end
def within(key, minimum, maximum)
  get_unit(key) * (maximum - minimum) + minimum
end

end

end