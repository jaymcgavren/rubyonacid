module RubyOnAcid

class Factory

  #Calls get_unit with key to get value between 0.0 and 1.0, then converts that value to be between given minimum and maximum.
  def within(key, minimum, maximum)
    get_unit(key) * (maximum - minimum) + minimum
  end
  
  #Returns true if get_unit(key) returns greater than 0.5.
  def boolean(key)
    get_unit(key) >= 0.5
  end
  
end

end