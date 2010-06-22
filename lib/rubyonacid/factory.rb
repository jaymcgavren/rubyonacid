module RubyOnAcid

#The parent class for all other Factories.
#Should not normally be instantiated directly.
class Factory

  #An array of factories to be queried by get_unit and have their return values averaged.
  attr_accessor :source_factories

  #Takes a hash with these keys and defaults:
  #  :source_factories => []
  def initialize(options = {})
    @source_factories = options[:source_factories] || []
  end
  
  #Calls #get_unit(key) on each source factory and averages results.
  def get_unit(key)
    return 0.0 if source_factories.empty?
    values = source_factories.map{|factory| factory.get_unit(key)}
    average = values.inject(0.0){|sum, value| sum += value} / source_factories.size
  end

  #Calls get_unit with key to get value between 0.0 and 1.0, then converts that value to be between given minimum and maximum.
  def within(key, minimum, maximum)
    get_unit(key) * (maximum - minimum) + minimum
  end
  
  #Calls get_unit with key to get value between 0.0 and 1.0, then converts that value to be between given minimum and maximum.
  def get(key, options = {})
    options[:min] ||= 0.0
    options[:max] ||= options[:min] + 1.0
    (get_unit(key) * (options[:max] - options[:min])) + options[:min]
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