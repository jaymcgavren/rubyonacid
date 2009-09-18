require 'generator'

module RubyOnAcid


class RandomGenerator < Generator
  #Returns a random value between 0 and 1.
  def get(key)
    rand
  end
end


end
