module RubyOnAcid

class Factory

  def initialize(*args)
    @minimums = {}
    @maximums = {}
  end

  #Calls get_unit with key to get value between 0.0 and 1.0, then converts that value to be between given minimum and maximum.
  def within(key, minimum, maximum)
    get_unit(key) * (maximum - minimum) + minimum
  end
  
  #Calls get_unit with key to get value between 0.0 and 1.0, then converts that value to be between given minimum and maximum.
  def get(key, options = {})
    @minimums[key] = (options[:min] || @minimums[key] || 0.0)
    @maximums[key] = (options[:max] || @maximums[key] || (@minimums[key] > 1.0 ? @minimums[key] + 1.0 : 1.0))
    get_unit(key) * (@maximums[key] - @minimums[key]) + @minimums[key]
  end
  
  #Returns true if get_unit(key) returns greater than 0.5.
  def boolean(key)
    get_unit(key) >= 0.5
  end
  
  #Calls get_unit with key to get value between 0.0 and 1.0, then converts that value to an index within the given list of choices.
  #choices can be an array or an argument list of arbitrary size.
  def choose(key, *choices)
    all_choices = choices.flatten
    index = (get_unit(key) * all_choices.length).floor
    index = all_choices.length - 1 if index > all_choices.length - 1
    all_choices[index]
  end
  
  
end

end