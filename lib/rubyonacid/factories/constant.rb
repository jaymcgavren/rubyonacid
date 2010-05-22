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
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :value => 0.0
  def initialize(options = {})
    super
    @value = options[:value] || 0.0
  end
  
  #Returns assigned value.
  def get_unit(key)
    @value
  end

end

end