# include Curses
# i=0
# loop{
#   setpos 12*(Math.sin(i)+1),40*(Math.cos(i*0.2)+1)
#   addstr'.'
#   i+=0.01
#   refresh
# }

require 'rubyonacid/factory'

module RubyOnAcid

#Produces a Lissajous curve over pairs of keys.
class LissajousFactory < Factory
  
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
  
  def tuple(*keys)
    @counters[keys.first] ||= 0
    @counters[keys.first] += @interval
    return_values = []
    keys.each_with_index do |k, i|
      if i % 2 == 0
        return_values << calculate_x(@counters[keys.first])
      else
        return_values << calculate_y(@counters[keys.first])
      end
    end
    return_values
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