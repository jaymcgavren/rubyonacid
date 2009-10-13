require 'rubyonacid/factory'

module RubyOnAcid

class MetaFactory < Factory
  
  attr_accessor :factory_pool
  attr_accessor :assigned_factories
  
  def initialize(factory_pool = [])
    @factory_pool = factory_pool
    @assigned_factories = {}
  end
  
  def assign_factory(key, factory)
    @assigned_factories[key] = factory
  end
  
  def get_unit(key)
    @assigned_factories[key] ||= @factory_pool[rand(@factory_pool.length)]
    @assigned_factories[key].get_unit(key)
  end
  
  def reset_assignments
    @assigned_factories.clear
  end

end

end