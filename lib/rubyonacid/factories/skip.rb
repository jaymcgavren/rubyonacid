require 'rubyonacid/factory'
require 'rubyonacid/random_number_generator'

module RubyOnAcid

#Returns the minimum or the maximum at random (influenced by the given odds).
class SkipFactory < Factory
  include RubyOnAcid::RandomNumberGenerator
  
  #The percentage odds that the factory will return 0 instead of 1.
  attr_accessor :odds
  #The numeric seed used for the random number generator.
  attr_accessor :rng_seed
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :odds => 0.1
  #  :rng_seed => Random.new_seed
  def initialize(options = {})
    super
    @odds = options[:odds] || 0.1
    @rng_seed = options[:rng_seed] || Random.new_seed
  end
  
  #If a random number between 0 and 1 is less than the assigned odds value, will return 0 (a "skip").
  #Otherwise returns 1.
  def get_unit(key)
    generate_random_number < @odds ? 0.0 : 1.0
  end

end

end
