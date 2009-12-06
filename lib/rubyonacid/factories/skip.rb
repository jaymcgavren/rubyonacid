require 'rubyonacid/factory'

module RubyOnAcid

#Returns the minimum or the maximum at random (influenced by the given odds).
class SkipFactory < Factory
  
  #The percentage odds that the factory will return 0 instead of 1.
  attr_accessor :odds
  
  def initialize(odds = 0.1)
    super
    @odds = odds
  end
  
  #If a random number between 0 and 1 is less than the assigned odds value, will return 0 (a "skip").
  #Otherwise returns 1.
  def get_unit(key)
    rand < @odds ? 0.0 : 1.0
  end

end

end