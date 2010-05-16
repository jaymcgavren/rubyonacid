require 'rubyonacid/factory'

module RubyOnAcid

#Rounds values from a source factory, useful for clustering values into groups.
class RoundingFactory < Factory
  
  #Source values will be rounded to the nearest multiple of this value.
  attr_accessor :nearest
  
  def initialize(options = {})
    super
    @nearest = options[:nearest] || 0.1
  end
  
  def get_unit(key)
    round_to(super, @nearest)
  end

  private

    def round_to(value, multiple_of)
      quotient, modulus = value.divmod(multiple_of)
      if modulus / multiple_of < 0.5
        return multiple_of * quotient
      else
        value = multiple_of * (quotient + 1)
        return value > 1.0 ? 1.0 : value
      end
    end  

end

end