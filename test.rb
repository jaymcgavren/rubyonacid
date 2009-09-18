require 'rubygems'
require 'wx'
require 'generators/loop'

class MyApp < Wx::App

 def on_init

   #TODO: Substitute your favorite Generator here!
   @generator = RubyOnAcid::LoopGenerator.new

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
     green_pen = Wx::Pen.new(Wx::Colour.new((get(:red) * 255).to_i, 255, (get(:blue) * 255).to_i), 3)
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
         surface.draw_line(x, (get(:y) * 300).to_i, (get(:x2) * 300).to_i, (get(:y2) * 300).to_i)
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
 
 def get(key)
    value = @generator.get(key)
    value
 end

end

app = MyApp.new
app.main_loop