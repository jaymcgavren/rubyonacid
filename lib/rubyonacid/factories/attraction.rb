require 'rubyonacid/factory'

module RubyOnAcid

class AttractionFactory < Factory
  
  SQUARE_ROOT_OF_TWO = Math.sqrt(2.0)
  
  #Factory to get values from.
  attr_accessor :source_factory
  
  #Values from source_factory will be "pulled" toward values from this factory.
  attr_accessor :attractor_factory
  
  def initialize(options = {})
    super
    @source_factory = options[:source_factory]
    @attractor_factory = options[:attractor_factory]
  end
  
  #Get a value from the source_factory and a value from the attractor_factory.
  #The source_factory value will be adjusted to be closer to the attractor_factory value.
  #The closer the values are, the greater the adjustment.
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