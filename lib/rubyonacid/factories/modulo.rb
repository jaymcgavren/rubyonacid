require 'rubyonacid/factory'

module RubyOnAcid

#Gets values from a source factory and returns the same value the given number of times before getting a fresh value.
class ModuloFactory < Factory
  
  #Factory to get values from.
  attr_accessor :source_factory
  
  def initialize(source_factory = nil)
    super
    @source_factory = source_factory
    @prior_values = {}
  end
  
  #Returns the value of get_unit on the source factory the assigned number of times.
  def get_unit(key)
    @prior_values[key] ||= 0
    @prior_values[key] = (@prior_values[key] + @source_factory.get_unit(key)) % 1
  end
  
end

end