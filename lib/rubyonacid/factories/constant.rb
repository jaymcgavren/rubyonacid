require 'rubyonacid/factory'

module RubyOnAcid

#A factory that returns a preset value for all keys.
class ConstantFactory < Factory
  
  #A value between 0 and 1 that get_unit will return.
  attr_accessor :value
  def value=(value)
    raise "assigned #{value} to value, must be between -1 and 1" if value < -1 or value > 1
    @value = value
  end
  
  def initialize(value = 0.5)
    super
    @value = value
  end
  
  #Returns assigned value.
  def get_unit(key)
    @value
  end

end

end