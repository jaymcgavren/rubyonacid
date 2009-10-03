require 'rubyonacid/factory'

module RubyOnAcid

class SkipFactory < Factory
  
  attr_accessor :odds
  
  def initialize
    @odds = 0.1
  end
  
  #If a random number between 0 and 1 is less than the assigned odds value, will return 0 (a "skip").
  #Otherwise returns 1.
  def get_unit(key)
    rand < @odds ? 0.0 : 1.0
  end

end

end