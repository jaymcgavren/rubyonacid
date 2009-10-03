require 'generator'

module RubyOnAcid

class RandomGenerator < Generator

  #Returns a random value between 0 and 1.
  def get_unit(key)
    rand
  end

def within(key, minimum, maximum)
  get_unit(key) * (maximum - minimum) + minimum
end

end


end
