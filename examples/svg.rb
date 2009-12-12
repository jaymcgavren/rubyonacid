require 'rubygems'
require 'rubyonacid/factories/example'

def svg(factory)
  return <<-EOD.strip
    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" version="1.1">
      #{shapes(factory).join("\n")}
    </svg>
  EOD
end

def shapes(factory)
  shapes = []
  1000.times do
    shapes << case factory.choose(:shape, :rectangle, :ellipse, :line)
    when :rectangle : rectangle(factory)
    when :ellipse : ellipse(factory)
    when :line : line(factory)
    end
  end
  shapes
end

def rectangle(factory)
  return <<-EOD
    <rect
      x='#{factory.get(:x, :max => 100)}%'
      y='#{factory.get(:y, :max => 100)}%'
      width='#{factory.get(:width, :max => 300)}'
      height='#{factory.get(:height, :max => 300)}'
      style='#{style(factory)}'
      transform='#{transform(factory)}'
    />
  EOD
end

def ellipse(factory)
  return <<-EOD
    <ellipse
      cx='#{factory.get(:x, :max => 100)}%'
      cy='#{factory.get(:y, :max => 100)}%'
      rx='#{factory.get(:width, :max => 300)}'
      ry='#{factory.get(:height, :max => 300)}'
      style='#{style(factory)}'
      transform='#{transform(factory)}'
    />
  EOD
end

def line(factory)
  return <<-EOD
    <line
      x1='#{factory.get(:x, :max => 100)}%'
      y1='#{factory.get(:y, :max => 100)}%'
      x2='#{factory.get(:x2, :max => 100)}%'
      y2='#{factory.get(:y2, :max => 100)}%'
      stroke='#{color(factory)}'
      stroke-width='#{factory.get(:width, :max => 20)}'
      stroke-opacity='#{factory.get(:opacity)}'
    />
  EOD
end

def style(factory)
  "fill:#{color(factory)};fill-opacity:#{factory.get(:opacity)};"
end

def color(factory)
  "rgb(#{factory.get(:red, :max => 255).to_i},#{factory.get(:green, :max => 255).to_i},#{factory.get(:blue, :max => 255).to_i})"
end

def transform(factory)
  return <<-EOD
    rotate(#{factory.get(:rotation, :max => 360)})
    translate(#{factory.get(:x_translate, :max => 100)}, #{factory.get(:y_translate, :max => 100)})
    scale(#{factory.get(:scale, :max => 2)})
    skewX(#{factory.get(:x_skew, :max => 360)})
    skewY(#{factory.get(:y_skew, :max => 360)})
  EOD
end

factory = RubyOnAcid::ExampleFactory.new
puts svg(factory)
