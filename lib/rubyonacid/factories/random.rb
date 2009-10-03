require 'rubyonacid/factory'

module RubyOnAcid

class RandomFactory < Factory

  #Returns a random value between 0 and 1.
  def get_unit(key)
    rand
  end

end


end
