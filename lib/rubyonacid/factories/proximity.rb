require 'rubyonacid/factory'

module RubyOnAcid

#Rounds values from a source factory, useful for clustering values into groups.
class ProximityFactory < Factory
  
  attr_accessor :target
  attr_accessor :scaled_key
  
  def initialize(options = {})
    super
    @target = options[:target] || rand
  end
  
  def get_unit(key)
    1.0 - (super - @target).abs
  end
  
  def to_s
    [
      super,
      @target,
      source_factories
    ].join(" ")
  end
  
  private
        
    def target(key)
      @targets[key] ||= rand
      @targets[key]
    end
  
end

end