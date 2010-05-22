require 'rubyonacid/factory'

module RubyOnAcid

#Allows values to be assigned from an external source.
class InputFactory < Factory

  #Takes a hash with all keys supported by Factory.
  def initialize
    super
    @input_values = {}
    @key_assignments = {}
    @largest_seen_values = {}
    @smallest_seen_values = {}
  end
  
  #Retrieves the next stored value for the given key.
  #The key that values are pulled from will not necessarily be the same as that passed to put() - value queue keys are assigned to get_unit() keys at random.
  #Retrieve average from source factories if no queued values are available, or zero if no source factories are assigned.
  def get_unit(key)
    current_key = assigned_key(key)
    if @input_values[current_key] and @input_values[current_key].length > 0
      return scale(current_key, @input_values[current_key].shift) || super(current_key) || 0.0
    else
      return super(current_key) || 0.0
    end
  end

  #Store a value for the given key.
  #Values will be scaled to the range 0 to 1 - the largest value yet seen will be scaled to 1.0, the smallest yet seen to 0.0.
  def put(key, value)
    value = value.to_f
    @input_values[key] ||= []
    @input_values[key] << value
    @smallest_seen_values[key] ||= 0.0
    if @largest_seen_values[key] == nil or @smallest_seen_values[key] > @largest_seen_values[key]
      @largest_seen_values[key] = @smallest_seen_values[key] + 1.0
    end
    @smallest_seen_values[key] = value if value < @smallest_seen_values[key]
    @largest_seen_values[key] = value if value > @largest_seen_values[key]
  end
  
  #Clears all stored input values for all keys.
  def clear_input_values
    @input_values = {}
  end
  
  #Clear all value queue key assignments.
  def clear_assigned_keys
    @assigned_keys = {}
  end
  
  private
  
    def assigned_key(key)
      return @key_assignments[key] if @key_assignments[key]
      key_pool = @input_values.keys - @key_assignments.values
      @key_assignments[key] = key_pool[rand(key_pool.length)]
      @key_assignments[key]
    end
    
    #Scales a value between the largest and smallest values seen for a key.
    #Returns a value in the range 0 to 1.
    def scale(key, value)
      (value - @smallest_seen_values[key]) / (@largest_seen_values[key] - @smallest_seen_values[key])
    end
  
end

end