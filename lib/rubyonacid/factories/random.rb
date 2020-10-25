require 'rubyonacid/factory'
require 'rubyonacid/random_number_generator'

module RubyOnAcid

#Returns random numbers between the minimum and the maximum.
class RandomFactory < Factory
  include RubyOnAcid::RandomNumberGenerator

  #The numeric seed used for the random number generator.
  attr_accessor :rng_seed
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :rng_seed => Random.new_seed
  def initialize(options = {})
    super
    @rng_seed = options[:rng_seed] || Random.new_seed
  end
  
  #Returns a random value between 0 and 1.
  def get_unit(key)
    generate_random_number
  end

end

end
