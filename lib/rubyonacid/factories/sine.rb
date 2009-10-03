require 'rubyonacid/factory'

module RubyOnAcid

class SineFactory < Factory
  
  attr_accessor :interval
  
  def initialize
    @counters = Hash.new{|h,k| h[k] = 0}
    @interval = 0.1
  end
  
  #Increment counter for key and get its sine, then scale it between 0 and 1.
  def get_unit(key)
    @counters[key] += @interval
    (Math.sin(@counters[key]) + 1) / 2
  end
  
end

end