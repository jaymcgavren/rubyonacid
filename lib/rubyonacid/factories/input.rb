require 'rubyonacid/factory'

module RubyOnAcid

class InputFactory < Factory
  
  def initialize
    super
    @input_values = {}
    @key_assignments = {}
    @largest_seen_values = {}
    @smallest_seen_values = {}
  end
  
  def get_unit(key)
    current_key = assigned_key(key)
    if @input_values[current_key] and @input_values[current_key].length > 0
      return scale(current_key, @input_values[current_key].shift) || default_value(key)
    else
      return default_value(key)
    end
  end
  
  def default_value(key)
    0.0
  end
  
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
  
  def clear_input_values
    @input_values = {}
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