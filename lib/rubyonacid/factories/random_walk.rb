require 'rubyonacid/factory'

module RubyOnAcid

#Each subsequent call subtracts or adds a random amount to a given key's value.
class RandomWalkFactory < Factory

  #The maximum amount to change counters by.
  attr_accessor :interval
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :interval => 0.001
  #  :rng_seed => Random.new_seed
  def initialize(options = {})
    super
    @start_value = 0.0
    @values = {}
    @interval = options[:interval] || 0.001
    @rng = Random.new(options[:rng_seed] || Random.new_seed)
  end
  
  #Add a random amount ranging between interval and -1 * interval to the given key's value and return the new value.
  def get_unit(key)
    @values[key] ||= generate_random_number
    @values[key] += (generate_random_number * (2 * @interval)) - @interval
    @values[key] = 1.0 if @values[key] > 1.0
    @values[key] = 0.0 if @values[key] < 0.0
    @values[key]
  end

  private def generate_random_number
    @rng.rand
  end

end

end
