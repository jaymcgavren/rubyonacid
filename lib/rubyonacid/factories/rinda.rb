require 'rinda/rinda' 
require 'rubyonacid/factory'

module RubyOnAcid

class RindaFactory < Factory
  
  #Time in seconds to wait for a value before giving up and returning the last retrieved value for the given key.
  #Default is 0, which will return immediately.
  attr_accessor :timeout
  #The URI to connect to.  Default is "druby://127.0.0.1:7632" (7632 == RNDA).
  attr_accessor :uri
  
  def initialize(uri = "druby://127.0.0.1:7632", timeout = 0)
    @uri = uri
    @timeout = timeout
    @prior_values = {}
  end
  
  def start_service
    DRb.start_service 
    @space = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, @uri))
  end
  
  #Get key from Rinda server.
  def get_unit(key)
    @prior_values[key] ||= 0.0
    begin
      key, value = @space.take([key, Float], @timeout)
      @prior_values[key] = value
    rescue Rinda::RequestExpiredError => exception
      value = @prior_values[key]
    end
    value
  end

end

end
