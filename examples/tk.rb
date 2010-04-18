require 'rubyonacid/factories/example'
require 'tk'

#This factory will be in charge of all drawing coordinates, colors, etc.
f = RubyOnAcid::ExampleFactory.new

#A skip factory, in charge of randomly resetting the meta factory.
resetter = RubyOnAcid::SkipFactory.new(0.999)

#The window to draw to.
canvas = TkCanvas.new(:width => 400, :height => 400)
canvas.pack

#The line objects we create will be stored here.
lines = []

#Create a thread to update the window while it's displayed.
Thread.new do
  loop do
    
    #Get red, green, and blue values for a color from the factory.
    #Format is #RRGGBB in hexadecimal (like HTML).
    color = sprintf("#%02x%02x%02x",
      f.get(:red, :max => 254).to_i,
      f.get(:green, :max => 254).to_i,
      f.get(:blue, :max => 254).to_i
    )
    
    #Create and store a line of the chosen color.
    #Get width and locations of the endpoints from the factory.
    lines << TkcLine.new(
      canvas,
      f.get(:x1, :max => 400),
      f.get(:y1, :max => 400),
      f.get(:x2, :max => 400),
      f.get(:y2, :max => 400),
      :width => f.get(:width, :min => 5, :max => 30),
      :fill => color
    )
    
    #If the resetter returns true, tell the ExampleFactory to reassign
    #its source factories to different keys.
    f.reset_assignments if resetter.boolean(:reset)
    
    #Delete the oldest line if we have accumulated too many.
    lines.shift.delete if lines.length > 1000
    
  end
end

#Display the window.
canvas.mainloop
