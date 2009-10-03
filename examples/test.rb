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
 
    @g = RubyOnAcid::MetaFactory.new
    @g.factories << RubyOnAcid::FlashFactory.new
    @g.factories << RubyOnAcid::IncrementFactory.new
    @g.factories << RubyOnAcid::LoopFactory.new
    @g.factories << RubyOnAcid::RandomFactory.new
    @g.factories << RubyOnAcid::SineFactory.new
    @g.factories << RubyOnAcid::SkipFactory.new
 
    @value = 0
    #Containing frame.
    frame = Wx::Frame.new(nil, :size => [WIDTH, HEIGHT])
    frame.show
 
    #Offscreen drawing buffer.
    buffer = Wx::Bitmap.new(WIDTH, HEIGHT)
 
    #Displays drawing.
    window = Wx::Window.new(frame, :size => [WIDTH, HEIGHT])
    window.evt_paint do |event|
      update_window(window, buffer)
    end
 
    @i = 0
    
    #Animate periodically.
    t = Wx::Timer.new(self, 55)
    evt_timer(55) {animate(window, buffer)}
    t.start(33)
 
  end
 
  def animate(window, buffer)
     buffer.draw do |surface|
       surface.pen = Wx::Pen.new(
           Wx::Colour.new(
             @g.within(:red, 0, 255).to_i,
             @g.within(:green, 0, 255).to_i,
             @g.within(:blue, 0, 255).to_i
           ),
           @g.within(:width, 1, 5).to_i
       )
       surface.draw_line(
          @g.within(:x, 0, WIDTH).to_i,
          @g.within(:y, 0, HEIGHT).to_i,
          @g.within(:x2, 0, WIDTH).to_i,
          @g.within(:y2, 0, HEIGHT).to_i
       )
     end
     update_window(window, buffer)
  end

 def update_window(window, buffer)
   window.paint do |dc|
     #Copy the buffer to the viewable window.
     dc.draw_bitmap(buffer, 0, 0, false)
   end
 end
 
end

app = MyApp.new
app.main_loop