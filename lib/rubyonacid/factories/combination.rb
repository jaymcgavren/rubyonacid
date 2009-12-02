require 'rubyonacid/factory'

module RubyOnAcid

class CombinationFactory < Factory
  
  ADD = :add
  SUBTRACT = :subtract
  MULTIPLY = :multiply
  DIVIDE = :divide
  CONSTRAIN = :constrain
  WRAP = :wrap
  
  attr_accessor :source_factories
  attr_accessor :operation
  attr_accessor :constrain_mode
  
  def initialize(options = {})
    super
    @source_factories = options[:source_factories] || []
    @operation = options[:operation] || ADD
    @constrain_mode = options[:constrain_mode] || CONSTRAIN
  end
  
  def get_unit(key)
    combined_value = combine(key)
    constrain(combined_value)
  end
  
  private
    
    def combine(key)
      initial_value = @source_factories.first.get_unit(key)
      additional_values = @source_factories.slice(1, @source_factories.length - 1).map {|f| f.get_unit(key)}
      case @operation
      when ADD
        return additional_values.inject(initial_value) {|sum, value| sum + value}
      when SUBTRACT
        return additional_values.inject(initial_value) {|sum, value| sum - value}
      when MULTIPLY
        return additional_values.inject(initial_value) {|product, value| product * value}
      when DIVIDE
        return additional_values.inject(initial_value) {|product, value| product / value}
      else
        raise "invalid operation - must be ADD, MULTIPLY, SUBTRACT, or DIVIDE"
      end
    end
    
    def constrain(value)
      case @constrain_mode
      when CONSTRAIN
        if value > 1.0
          return 1.0
        elsif value < 0.0
          return 0.0
        else
          return value
        end
      when WRAP
        return value % 1.0
      end
    end
  
end

end