require 'rinda/rinda' 
require 'rubyonacid/factory'

module RubyOnAcid

class RindaFactory < Factory
  
  attr_accessor :uri
  
  #Takes the URI to connect to.  Default is "druby://127.0.0.1:7632" (7632 == RNDA).
  def initialize(uri = "druby://127.0.0.1:7632")
    @uri = uri
  end
  
  def start_service
    DRb.start_service 
    @space = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, @uri))
  end
  
  #Get key from Rinda server.
  def get_unit(key)
    key, value = @space.take([key, Float])
    value
  end

end

end