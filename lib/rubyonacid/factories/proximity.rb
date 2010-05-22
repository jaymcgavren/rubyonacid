require 'rubyonacid/factory'

module RubyOnAcid

#Scales values from source factories according to how close they are to a target value.
class ProximityFactory < Factory
  
  #The target value.
  attr_accessor :target
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :target => rand()
  def initialize(options = {})
    super
    @target = options[:target] || rand
  end

  #Return values approach 1.0 as the values from the source factories approach the target value.
  #Values approach zero as the source factory values approach a distance of 1.0 from the target value.
  def get_unit(key)
    1.0 - (super - @target).abs
  end
  
end

end