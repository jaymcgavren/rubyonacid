require 'rubyonacid/factory'

module RubyOnAcid

#Produces a "wave" pattern.
class SineFactory < Factory
  
  #Counters used to calculate sine values will be incremented by this amount with each query.
  attr_accessor :interval
  
  def initialize(interval = 0.1)
    super
    @counters = {}
    @interval = interval
  end
  
  #Increment counter for key and get its sine, then scale it between 0 and 1.
  def get_unit(key)
    @counters[key] ||= 0
    @counters[key] += @interval
    (Math.sin(@counters[key]) + 1) / 2
  end
  
end

end