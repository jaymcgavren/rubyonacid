require 'rubyonacid/factory'

module RubyOnAcid

#Increments from the minimum value, stopping at the maximum, or decrements from the maximum value, stopping at the minimum.
class RandomWalkFactory < Factory

  #The maximum amount to change counters by.
  attr_accessor :interval
  
  def initialize(options = {})
    super
    @start_value = 0.0
    @values = {}
    @interval = options[:interval] || 0.001
  end
  
  #Increment counter for given key and return it. Constrain between 0 and 1.
  def get_unit(key)
    @values[key] ||= rand
    @values[key] += (rand * (2 * @interval)) - @interval
    @values[key] = 1.0 if @values[key] > 1.0
    @values[key] = 0.0 if @values[key] < 0.0
    @values[key]
  end

end

end