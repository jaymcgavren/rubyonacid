require 'rubyonacid/factory'

module RubyOnAcid

#Allows values to be assigned from an external source.
class InputFactory < Factory

  #Takes a hash with all keys supported by Factory.
  def initialize
    super
    @input_value = {}
    @key_assignments = {}
    @largest_seen_values = {}
    @smallest_seen_values = {}
  end
  
  #Retrieves stored value for the given key.
  #The key that values are pulled from will not necessarily be the same as that passed to put() - value input keys are assigned to get_unit() keys at random.
  #Retrieve average from source factories if no queued values are available, or zero if no source factories are assigned.
  def get_unit(key)
    current_key = assigned_key(key)
    if @input_value[current_key]
      return scale(current_key, @input_value[current_key]) || super(current_key) || 0.0
    else
      return super(current_key) || 0.0
    end
  end

  #Store a value for the given key.
  #Values will be scaled to the range 0 to 1 - the largest value yet seen will be scaled to 1.0, the smallest yet seen to 0.0.
  def put(key, value)
    value = value.to_f
    @input_value[key] = value
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
  
  #Clear all value input key assignments.
  def clear_assigned_keys
    @assigned_keys = {}
  end
  
  private
  
    #Returns the input key assigned to the given get_unit key.
    #If none is assigned, randomly assigns one of the available input keys.
    def assigned_key(key)
      return @key_assignments[key] if @key_assignments[key]
      available_keys = @input_value.keys - @key_assignments.values
      if available_keys.include?(key)
        @key_assignments[key] = key
      else
        @key_assignments[key] = available_keys[rand(available_keys.length)]
      end
      @key_assignments[key]
    end
    
    #Scales a value between the largest and smallest values seen for a key.
    #Returns a value in the range 0 to 1.
    def scale(key, value)
      (value - @smallest_seen_values[key]) / (@largest_seen_values[key] - @smallest_seen_values[key])
    end
  
end

end