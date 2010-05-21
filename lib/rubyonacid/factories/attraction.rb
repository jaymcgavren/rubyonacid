require 'rubyonacid/factory'

module RubyOnAcid

class AttractionFactory < Factory
  
  SQUARE_ROOT_OF_TWO = Math.sqrt(2.0)
  
  #Values from source_factory will be "pulled" toward values from this factory.
  attr_accessor :attractor_factory
  
  def initialize(options = {})
    super
    @source_factory = options[:source_factory]
    @attractor_factory = options[:attractor_factory]
  end
  
  #Get a value from the source_factories and a value from the attractor_factory.
  #The source_factories average will be adjusted to be closer to the attractor_factory value.
  #The closer the values are, the greater the adjustment.
  def get_unit(key)
    # force = delta * @magnetism / (distance * Jemini::Math::SQUARE_ROOT_OF_TWO)
    value = super
    attractor_value = @attractor_factory.get_unit(key)
    distance = attractor_value - value
    value += distance / 2.0
    value
  end

end

end

# 0.5 1.0 0.5
# 0.7 1.0 0.3