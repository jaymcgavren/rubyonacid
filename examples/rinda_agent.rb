require 'rubygems'
require 'wx'
require 'rubyonacid/factories/meta'
require 'rubyonacid/factories/constant'
require 'rubyonacid/factories/flash'
require 'rubyonacid/factories/loop'
require 'rubyonacid/factories/random'
require 'rubyonacid/factories/repeat'
require 'rubyonacid/factories/rinda'
require 'rubyonacid/factories/sine'
require 'rubyonacid/factories/skip'



class MyApp < Wx::App

  WIDTH = 480
  HEIGHT = 480

  def on_init
    
    @f = RubyOnAcid::RindaFactory.new(ARGV[0])
    @f.default_factory = create_factory
    @f.start_service
    
    #A skip factory, in charge of randomly resetting the meta factory.
    @resetter = RubyOnAcid::SkipFactory.new(0.999)
    
    #Containing frame.
    frame = Wx::Frame.new(nil, :size => [WIDTH, HEIGHT])
    frame.show
 
    #Displays drawing.
    window = Wx::Window.new(frame, :size => [WIDTH, HEIGHT])
 
    #Animate periodically.
    t = Wx::Timer.new(self, 55)
    evt_timer(55) do
      window.paint{|surface| render(surface)}
      @f.default_factory.reset_assignments if @resetter.boolean(:reset)
    end
    t.start(33)
 
  end
 
  def create_factory
    random_factory = RubyOnAcid::RandomFactory.new
    
    #The MetaFactory assigns factories to requested value types.
    meta_factory = RubyOnAcid::MetaFactory.new
    #Loop factories loop from 0.0 to 1.0 (or 1.0 to 0.0 if the increment value is negative).
    meta_factory.factory_pool << RubyOnAcid::LoopFactory.new(0.01)
    meta_factory.factory_pool << RubyOnAcid::LoopFactory.new(-0.01)
    meta_factory.factory_pool << RubyOnAcid::LoopFactory.new(0.001)
    meta_factory.factory_pool << RubyOnAcid::LoopFactory.new(-0.001)
    #Constant factories always return the same value,
    meta_factory.factory_pool << RubyOnAcid::ConstantFactory.new(rand)
    meta_factory.factory_pool << RubyOnAcid::ConstantFactory.new(rand)
    meta_factory.factory_pool << RubyOnAcid::FlashFactory.new(rand(100))
    #Sine factories produce a "wave" pattern.
    meta_factory.factory_pool << RubyOnAcid::SineFactory.new(0.1)
    meta_factory.factory_pool << RubyOnAcid::SineFactory.new(-0.1)
    meta_factory.factory_pool << RubyOnAcid::SineFactory.new(0.01)
    meta_factory.factory_pool << RubyOnAcid::SineFactory.new(-0.01)
    meta_factory.factory_pool << RubyOnAcid::RepeatFactory.new(
      RubyOnAcid::LoopFactory.new(random_factory.within(:increment, -0.1, 0.1)),
      random_factory.within(:interval, 2, 100)
    )
    meta_factory.factory_pool << RubyOnAcid::RepeatFactory.new(
      RubyOnAcid::SineFactory.new(random_factory.within(:increment, -0.1, 0.1)),
      random_factory.within(:interval, 2, 100)
    )
    
    meta_factory
  end

  def render(surface)
    color = Wx::Colour.new(
      @f.get(:red, :max => 255).to_i,
      @f.get(:green, :max => 255).to_i,
      @f.get(:blue, :max => 255).to_i,
      @f.get(:alpha, :min => 50, :max => 200).to_i
    )
    surface.pen = Wx::Pen.new(color, @f.within(:width, 1, 5).to_i)
    surface.brush = Wx::Brush.new(color, Wx::SOLID)
    case @f.choose(:shape,
      :arc,
      :polygon,
      :line,
      # :rectangle,
      :circle,
      :spline
    )
    when :line
      surface.draw_line(
        @f.get(:x0, :max => WIDTH).to_i,
        @f.get(:y0, :max => HEIGHT).to_i,
        @f.get(:x1, :max => WIDTH).to_i,
        @f.get(:y1, :max => HEIGHT).to_i
      )
    when :rectangle
      surface.draw_rectangle(
        @f.get(:x0, :max => WIDTH).to_i,
        @f.get(:y0, :max => HEIGHT).to_i,
        @f.get(:x1, :max => WIDTH).to_i,
        @f.get(:y1, :max => HEIGHT).to_i
      )
    when :circle
      surface.draw_circle(
        @f.get(:x0, :max => WIDTH).to_i,
        @f.get(:y0, :max => HEIGHT).to_i,
        @f.get(:width, :max => WIDTH).to_i
      )
    when :arc
      surface.draw_elliptic_arc(
        @f.get(:x0, :max => WIDTH).to_i,
        @f.get(:y0, :max => HEIGHT).to_i,
        @f.get(:width, :max => WIDTH).to_i,
        @f.get(:height, :max => HEIGHT).to_i,
        @f.get(:arc_start, :max => 360).to_i,
        @f.get(:arc_end, :max => 360).to_i
      )
    when :polygon
      surface.draw_polygon(make_point_array)
    when :spline
      surface.draw_spline(make_point_array)
    end
  end

  def make_point_array
    points = []
    @f.get(:points, :min => 3, :max => 6).to_i.times do |i|
      points << Wx::Point.new(
        @f.get("x#{i}".to_sym, :max => WIDTH).to_i,
        @f.get("y#{i}".to_sym, :max => HEIGHT).to_i
      )
    end
    points
  end
  
end

app = MyApp.new
app.main_loop
