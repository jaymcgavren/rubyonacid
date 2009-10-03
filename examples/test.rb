require 'rubygems'
require 'wx'
require 'rubyonacid/generators/meta'
require 'rubyonacid/generators/flash'
require 'rubyonacid/generators/increment'
require 'rubyonacid/generators/loop'
require 'rubyonacid/generators/random'
require 'rubyonacid/generators/sine'
require 'rubyonacid/generators/skip'

class MyApp < Wx::App

 def on_init

   @g = RubyOnAcid::MetaGenerator.new
   @g.generators << RubyOnAcid::FlashGenerator.new
   @g.generators << RubyOnAcid::IncrementGenerator.new
   @g.generators << RubyOnAcid::LoopGenerator.new
   @g.generators << RubyOnAcid::RandomGenerator.new
   @g.generators << RubyOnAcid::SineGenerator.new
   @g.generators << RubyOnAcid::SkipGenerator.new

   @value = 0
   #Containing frame.
   frame = Wx::Frame.new(nil, :size => [300, 300])
   frame.show

   #Offscreen drawing buffer.
   buffer = Wx::Bitmap.new(300, 300)

   #Displays drawing.
   window = Wx::Window.new(frame, :size => [300, 300])
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
     green_pen = Wx::Pen.new(Wx::Colour.new(within(:red, 0, 255).to_i, 255, within(:blue, 0, 255).to_i), 3)
     black_pen = Wx::Pen.new(Wx::Colour.new(0, 0, 0), 0)
     buffer.draw do |surface|
       #Clear screen.
       surface.pen = black_pen
       surface.brush = Wx::BLACK_BRUSH
       surface.draw_rectangle(0, 0, 300, 300)
       #Draw lines.
       surface.pen = green_pen
       surface.pen.cap = Wx::CAP_ROUND
       300.times do |j|
         x = @i + j
         surface.draw_line(x, within(:y, 0, 300).to_i, within(:x2, 0, 300).to_i, within(:y2, 0, 300).to_i)
       end
     end
     #Update screen.
     update_window(window, buffer)
     @i += 1
     @i = 0 if @i > 300
 end

 def update_window(window, buffer)
   window.paint do |dc|
     #Copy the buffer to the viewable window.
     dc.draw_bitmap(buffer, 0, 0, false)
   end
 end
 
 def within(key, minimum, maximum)
    value = @g.within(key, minimum, maximum)
    value
 end

end

app = MyApp.new
app.main_loop