require 'rubyonacid/factory'

module RubyOnAcid

class ConstantFactory < Factory
  
  attr_accessor :value
  def value=(value)
    raise "assigned #{value} to value, must be between -1 and 1" if value < -1 or value > 1
    @value = value
  end
  
  def initialize(value = 0.5)
    super
    @value = value
  end
  
  #Increment counter for key, looping it around to opposite side if it exits boundary.
  def get_unit(key)
    @value
  end

end

end