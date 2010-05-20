#!/usr/bin/env ruby

require 'rubygems'
begin
  require 'wx'
rescue LoadError
  raise "It appears that wxruby is not installed. 'sudo gem install wxruby' to install it."
end
require 'rubyonacid/factories/example'

class MyApp < Wx::App

  WIDTH = 480
  HEIGHT = 480

  def on_init
    
    @f = RubyOnAcid::RindaFactory.new(:uri => ARGV[0] || "druby://127.0.0.1:7632")
    @f.default_factory = RubyOnAcid::ExampleFactory.new
    @f.start_service
    
    #A skip factory, in charge of randomly resetting the meta factory.
    @resetter = RubyOnAcid::SkipFactory.new(:odds => 0.999)
    
    #Set up window.
    frame = Wx::Frame.new(nil, :size => [WIDTH, HEIGHT])
    frame.show
    window = Wx::Window.new(frame, :size => [WIDTH, HEIGHT])
 
    #Animate periodically.
    t = Wx::Timer.new(self, 55)
    evt_timer(55) do
      window.paint{|surface| render(surface)}
      @f.default_factory.reset_assignments if @resetter.boolean(:reset)
    end
    t.start(33)

  end

  def render(surface)
    color = Wx::Colour.new(
      @f.get(:red, :max => 255).to_i,
      @f.get(:green, :max => 255).to_i,
      @f.get(:blue, :max => 255).to_i,
      @f.get(:alpha, :min => 50, :max => 200).to_i
    )
    surface.pen = Wx::Pen.new(color, @f.get(:width, :min => 1, :max => 5).to_i)
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
        @f.get(:x, :max => WIDTH).to_i,
        @f.get(:y, :max => HEIGHT).to_i,
        @f.get(:x1, :max => WIDTH).to_i,
        @f.get(:y1, :max => HEIGHT).to_i
      )
    when :rectangle
      surface.draw_rectangle(
        @f.get(:x, :max => WIDTH).to_i,
        @f.get(:y, :max => HEIGHT).to_i,
        @f.get(:x1, :max => WIDTH).to_i,
        @f.get(:y1, :max => HEIGHT).to_i
      )
    when :circle
      surface.draw_circle(
        @f.get(:x, :max => WIDTH).to_i,
        @f.get(:y, :max => HEIGHT).to_i,
        @f.get(:width, :max => WIDTH).to_i
      )
    when :arc
      surface.draw_elliptic_arc(
        @f.get(:x, :max => WIDTH).to_i,
        @f.get(:y, :max => HEIGHT).to_i,
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
