require 'rubyonacid/factory'

module RubyOnAcid

#Combines values from source factories together in the prescribed manner.
class CombinationFactory < Factory
  
  #Causes get_unit value of all source_factories to be added together.
  ADD = :add
  #Takes the get_unit value of the first of the source_factories and subtracts the get_unit value of all subsequent ones.
  SUBTRACT = :subtract
  #Causes get_unit value of all source_factories to be multiplied.
  MULTIPLY = :multiply
  #Takes the get_unit value of the first of the source_factories and divides the result by the get_unit value of all subsequent ones.
  DIVIDE = :divide
  #Causes get_unit values above 1 to be truncated at 1 and values below 0 to be truncated at 0.
  CONSTRAIN = :constrain
  #Causes get_unit values above 1 to wrap to 0 and values below 0 to wrap to 1.
  WRAP = :wrap
  
  #The operation get_unit will perform to combine source factory values.
  attr_accessor :operation
  #The method get_unit will use to constrain values between 0 and 1.
  attr_accessor :constrain_mode
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :operation => ADD
  #  :constrain_mode => WRAP
  def initialize(options = {})
    super
    @operation = options[:operation] || ADD
    @constrain_mode = options[:constrain_mode] || WRAP
  end
  
  #Queries all source_factories with given key and combines their return values with the set operation.
  #Values will be constrained between 0 and 1 with the set constrain_mode.
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
      else
        raise "invalid constrain mode - must be CONSTRAIN or WRAP"
      end
    end
  
end

end