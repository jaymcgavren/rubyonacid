require 'rubyonacid/factory'

module RubyOnAcid

class AttractionFactory < Factory
  
  SQUARE_ROOT_OF_TWO = Math.sqrt(2.0)
  
  #Factory to get values from.
  attr_accessor :source_factory
  
  attr_accessor :attractor_factory
  
  def initialize(source_factory = nil, attractor_factory = nil)
    super
    @source_factory = source_factory
    @attractor_factory = attractor_factory
  end
  
  def get_unit(key)
    # force = delta * @magnetism / (distance * Jemini::Math::SQUARE_ROOT_OF_TWO)
    value = @source_factory.get_unit(key)
    attractor_value = @attractor_factory.get_unit(key)
    distance = value - attractor_value
    return_value = value - (0.1 / (distance * SQUARE_ROOT_OF_TWO))
    if value > attractor_value and return_value < attractor_value
      return_value = attractor_value
    elsif value < attractor_value and return_value > attractor_value
      return_value = attractor_value
    end
    return_value
  end

end

end