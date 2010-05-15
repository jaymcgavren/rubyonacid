require 'rubyonacid/factory'

module RubyOnAcid

#The MetaFactory assigns factories to requested value types.
class MetaFactory < Factory
  
  #An array of Factory objects to assign to keys.
  attr_accessor :factory_pool
  
  def initialize(options = {})
    super
    @factory_pool = options[:factory_pool] || []
    @assigned_factories = {}
  end
  
  #Assign a factory for subsequent get_unit requests for the given key.
  def assign_factory(key, factory)
    @assigned_factories[key] = factory
  end
  
  #Returns the value of get_unit from the Factory assigned to the given key.
  #When a key is needed that a Factory is not already assigned to, one will be assigned at random from the factory_pool.
  def get_unit(key)
    @assigned_factories[key] ||= @factory_pool[rand(@factory_pool.length)]
    @assigned_factories[key].get_unit(key)
  end
  
  #Clear all factory assignments.
  def reset_assignments
    @assigned_factories.clear
  end

end

end