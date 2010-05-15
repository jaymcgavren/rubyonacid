require 'rinda/rinda' 
require 'rubyonacid/factory'

module RubyOnAcid

#Allows values to be sent over the network.  For more information, see the Ruby standard library documentation for Rinda.
class RindaFactory < Factory
  
  #Time in seconds to wait for a value before giving up and returning a default value for the given key.
  #Default is 0, which will return immediately.
  attr_accessor :timeout
  #The URI to connect to.  Default is "druby://127.0.0.1:7632" (7632 == RNDA).
  attr_accessor :uri
  
  def initialize(options = {})
    super
    @uri = options[:uri] || "druby://127.0.0.1:7632"
    @timeout = options[:timeout] || 0
    @prior_values = {}
  end
  
  #Create the Rinda TupleSpace for clients to write to.
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
      if source_factories.empty?
        value = @prior_values[key]
      else
        value = super
      end
    end
    value
  end

end

end
