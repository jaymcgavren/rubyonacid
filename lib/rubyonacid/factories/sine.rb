require 'rubyonacid/factory'

module RubyOnAcid

#Produces a "wave" pattern.
class SineFactory < Factory
  
  #Counters used to calculate sine values will be incremented by this amount with each query.
  attr_accessor :interval
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :interval => 0.1
  def initialize(options = {})
    super
    @counters = {}
    @interval = options[:interval] || 0.1
  end
  
  #Increment counter for key and get its sine, then scale it between 0 and 1.
  def get_unit(key)
    @counters[key] ||= 0
    @counters[key] += @interval
    (Math.sin(@counters[key]) + 1) / 2
  end
  
end

end