#!/usr/bin/ruby

require 'rubygems'
require 'RMagick'

require 'rubyonacid/factories/meta'
require 'rubyonacid/factories/flash'
require 'rubyonacid/factories/increment'
require 'rubyonacid/factories/loop'
require 'rubyonacid/factories/random'
require 'rubyonacid/factories/sine'
require 'rubyonacid/factories/skip'

@f = RubyOnAcid::MetaFactory.new
@f.factories << RubyOnAcid::LoopFactory.new
@f.factories << RubyOnAcid::FlashFactory.new
# @f.factories << RubyOnAcid::RandomFactory.new
@f.factories << RubyOnAcid::SineFactory.new
@f.factories << RubyOnAcid::SkipFactory.new

def get(key)
  @f.within(key, 1, key.to_i)
end

canvas = Magick::Image.new(240, 300,
              Magick::HatchFill.new('white','lightcyan2'))
gc = Magick::Draw.new

while RubyOnAcid::SkipFactory.new(0.001).boolean(:continue_loop)

  # Draw ellipse
  gc.stroke('red')
  gc.stroke_width(get(10))
  gc.fill_opacity(0)
  gc.ellipse(get(120), get(150), get(80), get(120), 0, get(270))

  # Draw endpoints
  gc.stroke('gray50')
  gc.stroke_width(get(1))
  gc.circle(120, 150, 124, 150)
  gc.circle(200, 150, 204, 150)
  gc.circle(120,  30, 124,  30)

  # Draw lines
  gc.line(get(120), get(150), get(200), get(150))
  gc.line(get(120), get(150), get(120),  get(30))

  # Annotate
  gc.stroke('transparent')
  gc.fill('black')
  gc.text(130, 35, "End")
  gc.text(188, 135, "Start")
  gc.text(130, 95, "'Height=#{get(120)}'")
  gc.text(55, 155, "'Width=#{get(80)}'")

end

gc.draw(canvas)
canvas.write('shapes2.gif')
