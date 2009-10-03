require 'generator'

module RubyOnAcid

class MetaGenerator < Generator
  
  attr_accessor :generators
  
  def initialize
    @generators = []
    @assigned_generators = {}
  end
  
  def get_unit(key)
    @assigned_generators[key] ||= @generators[rand(@generators.length)]
    @assigned_generators[key].get_unit(key)
  end
def within(key, minimum, maximum)
  get_unit(key) * (maximum - minimum) + minimum
end

end

end