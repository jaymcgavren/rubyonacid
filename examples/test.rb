require 'rubygems'
require 'wx'
require 'rubyonacid/factories/meta'
require 'rubyonacid/factories/flash'
require 'rubyonacid/factories/increment'
require 'rubyonacid/factories/loop'
require 'rubyonacid/factories/random'
require 'rubyonacid/factories/sine'
require 'rubyonacid/factories/skip'



class MyApp < Wx::App

  WIDTH = 480
  HEIGHT = 480

  def on_init
    
    #The MetaFactory assigns factories to requested value types.
    @f = RubyOnAcid::MetaFactory.new
    #Loop factories loop from 0.0 to 1.0 (or 1.0 to 0.0 if the increment value is negative).
    @f.factories << RubyOnAcid::LoopFactory.new(0.01)
    @f.factories << RubyOnAcid::LoopFactory.new(-0.01)
    #Random factories generate random values.
    @f.factories << RubyOnAcid::RandomFactory.new
    #Sine factories produce a "wave" pattern.
    @f.factories << RubyOnAcid::SineFactory.new(0.1)
    @f.factories << RubyOnAcid::SineFactory.new(-0.1)
    
    #This is an additional skip factory, in charge of randomly resetting the meta factory.
    @resetter = RubyOnAcid::SkipFactory.new(0.999)
    
    #Containing frame.
    frame = Wx::Frame.new(nil, :size => [WIDTH, HEIGHT])
    frame.show
 
    #Displays drawing.
    window = Wx::Window.new(frame, :size => [WIDTH, HEIGHT])
 
    #Animate periodically.
    t = Wx::Timer.new(self, 55)
    evt_timer(55) {animate(window)}
    t.start(33)
 
  end
 
  def animate(window)
     window.paint do |surface|
       surface.pen = Wx::Pen.new(
           Wx::Colour.new(
             @f.within(:red, 0, 255).to_i,
             @f.within(:green, 0, 255).to_i,
             @f.within(:blue, 0, 255).to_i,
             @f.within(:alpha, 50, 255).to_i
           ),
           @f.within(:width, 1, 5).to_i
       )
       surface.draw_line(
          @f.within(:x, 0, WIDTH).to_i,
          @f.within(:y, 0, HEIGHT).to_i,
          @f.within(:x2, 0, WIDTH).to_i,
          @f.within(:y2, 0, HEIGHT).to_i
       )
     end
     @f.reset_assignments if @resetter.boolean(:reset)
  end

end

app = MyApp.new
app.main_loop