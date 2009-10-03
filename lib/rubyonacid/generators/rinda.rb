require 'rinda/rinda' 
require 'generator'

module RubyOnAcid

class RindaGenerator < Generator
  
  attr_accessor :uri
  
  def initialize
    @uri = "druby://127.0.0.1:2243" #2243 == ACID
  end
  
  def start_service
    DRb.start_service 
    @space = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, @uri))
  end
  
  #Get key from Rinda server.
  def get_unit(key)
    key, value = @space.take([key, nil])
    value
  end

def within(key, minimum, maximum)
  get_unit(key) * (maximum - minimum) + minimum
end

end

end