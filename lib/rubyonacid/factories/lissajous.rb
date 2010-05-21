require 'rubyonacid/factory'

module RubyOnAcid

#Produces a Lissajous curve over pairs of keys.
class LissajousFactory < Factory
  
  #Value to scale Y values by.  Affects the number of loops in a curve.
  attr_accessor :scale

  #Counters used to calculate sine/cosine values will be incremented by this amount with each query.
  attr_accessor :interval
  
  def initialize(options = {})
    super
    @scale = options[:scale] || 0.2
    @interval = options[:interval] || 0.1
    @counters = {}
    @x_y_assignments = {}
    @next_key_assignment = :x
  end
  
  def get_unit(key)
    unless @x_y_assignments[key]
      @x_y_assignments[key] = @next_key_assignment
      if @next_key_assignment == :x
        @next_key_assignment = :y
      else
        @next_key_assignment = :x
      end
    end
    @counters[key] ||= 0
    @counters[key] += @interval
    if @x_y_assignments[key] == :x
      return calculate_x(@counters[key])
    else
      return calculate_y(@counters[key])
    end
  end
  
  private
  
    def calculate_x(value)
      (Math.sin(value) + 1) / 2
    end
    
    def calculate_y(value)
      (Math.cos(value * scale) + 1) / 2
    end
  
end

end