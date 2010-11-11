begin
  require 'ruby-processing'
rescue LoadError
  fail "Could not find ruby-processing.  Install it with 'gem install ruby-processing'."
end
Processing::App::SKETCH_PATH = __FILE__
require 'rubyonacid/factories/example'


class Sketch < Processing::App
  
  def setup
    no_stroke
    @frame_count = 0
    @f = RubyOnAcid::ExampleFactory.new
  end
  
  def draw
    fill(
      @f.get(:red, :max => 255),
      @f.get(:green, :max => 255),
      @f.get(:blue, :max => 255),
      @f.get(:alpha, :min => 50, :max => 200)
    )
    x = @f.get(:x, :max => width)
    y = @f.get(:y, :max => height)
    width = @f.get(:width, :max => 200)
    height = @f.get(:height, :max => 200)
    case @f.choose(:shape, :rectangle, :ellipse)
    when :rectangle
      rect_mode 3 #CENTER
      rect x, y, width, height
    when :ellipse
      ellipse_mode 3 #CENTER
      ellipse x, y, width, height
    end
    @frame_count += 1
    if @frame_count > 100
      @frame_count = 0
      background 0
      @f.reset_assignments 
    end
  end
  
end

Sketch.new(:width => 1024, :height => 768, :title => 'http://gist.github.com/615896', :full_screen => false)