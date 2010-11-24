require 'rubyonacid/factory'

module RubyOnAcid

#The MetaFactory assigns its source factories to requested value types.
class MetaFactory < Factory
  
  #A hash with the Factories assigned to each key.
  attr_reader :assigned_factories
  
  #Takes a hash with all keys supported by Factory.
  def initialize(options = {})
    super
    @assigned_factories = {}
  end
  
  #Assign a factory for subsequent get_unit requests for the given key.
  def assign_factory(key, factory); @assigned_factories[key] = factory; end
  #Get the factory assigned for a given key.
  def assigned_factory(key); @assigned_factories[key]; end
  #Get an Array with all keys currently assigned.
  def assigned_keys; @assigned_factories.keys; end
  
  #Returns the value of get_unit from the Factory assigned to the given key.
  #When a key is needed that a Factory is not already assigned to, one will be assigned at random from the pool of source factories.
  def get_unit(key)
    @assigned_factories[key] ||= source_factories[rand(source_factories.length)]
    @assigned_factories[key].get_unit(key)
  end
  
  #Clear all factory assignments.
  def reset_assignments
    @assigned_factories.clear
    return true
  end

end

end