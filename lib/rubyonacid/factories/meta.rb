require 'rubyonacid/factory'

module RubyOnAcid

class MetaFactory < Factory
  
  attr_accessor :factories
  
  def initialize
    @factories = []
    @assigned_factories = {}
  end
  
  def get_unit(key)
    @assigned_factories[key] ||= @factories[rand(@factories.length)]
    @assigned_factories[key].get_unit(key)
  end
  
  def reset_assignments
    @assigned_factories.clear
  end

end

end