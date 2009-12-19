require 'rubyonacid/factory'

module RubyOnAcid

class RoundingFactory < Factory
  
  #Factory to get values from.
  attr_accessor :source_factory
  
  attr_accessor :nearest
  
  def initialize(source_factory = nil, nearest = 0.1)
    super
    @source_factory = source_factory
    @nearest = nearest
  end
  
  def get_unit(key)
    round_to(@source_factory.get_unit(key), @nearest)
  end

  private

    def round_to(value, multiple_of)
      quotient, modulus = value.divmod(multiple_of)
      if modulus / multiple_of < 0.5
        return multiple_of * quotient
      else
        return multiple_of * (quotient + 1)
      end
    end  

end

end