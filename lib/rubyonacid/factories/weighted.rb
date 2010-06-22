module RubyOnAcid

#The parent class for all other Factories.
#Should not normally be instantiated directly.
class WeightedFactory < Factory

  #A Hash with factories as keys and their weights as values.
  #get_unit value of each factory will be multiplied by its weight when averaging.
  attr_accessor :weights

  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :weights => {}
  def initialize(options = {})
    super
    @weights = options[:weights] || {}
  end
  
  #Calls #get_unit(key) on each source factory and multiples value by weight.
  #Then divides total of values by total weight to get weighted average.
  def get_unit(key)
    return 0.0 if source_factories.empty?
    sum = total_weight = 0.0
    source_factories.each do |factory|
      weight = weights[factory] || 1.0
      sum += factory.get_unit(key) * weight
      total_weight += weight
    end
    return 0.0 if total_weight == 0
    sum / total_weight
  end
  
end

end