require 'rubyonacid/factory'

module RubyOnAcid

class IncrementFactory < Factory
  
  attr_accessor :interval
  def interval=(value)
    @interval = value
    @start_value = (@interval < 0.0 ? 1.0 : 0.0) 
    @counters.each_key{|k| @counters[k] = @start_value}
  end
  
  def initialize(interval = 0.001)
    super
    @start_value = 0.0
    @counters = {}
    @interval = interval
  end
  
  #Increment counter for key and get its sine, then scale it between 0 and 1.
  def get_unit(key)
    @counters[key] ||= @start_value
    @counters[key] += @interval
    @counters[key] = 1.0 if @counters[key] > 1.0
    @counters[key] = 0.0 if @counters[key] < 0.0
    @counters[key]
  end

end

end