require 'rubyonacid/factory'

module RubyOnAcid

#Gets values from a source factory and returns the same value the given number of times before getting a fresh value.
class RepeatFactory < Factory
  
  #The number of times to repeat a value for a given key.
  attr_accessor :repeat_count
  
  def initialize(options = {})
    super
    @repeat_count = options[:repeat_count] || 2
    @repeat_counts = {}
    @values = {}
  end
  
  #Returns the value of get_unit on the source factory the assigned number of times.
  def get_unit(key)
    @repeat_counts[key] ||= 0
    if @repeat_counts[key] >= @repeat_count
      @values[key] = nil 
      @repeat_counts[key] = 0
    end
    @values[key] ||= super
    @repeat_counts[key] += 1
    @values[key]
  end
  
end

end