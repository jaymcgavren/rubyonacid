#!/usr/bin/env ruby

puts "This demo writes raw 8-bit PCM data to a file.  Ctrl-C to stop.  Import the file to Audacity (or a similar audio editing program) to hear the results."

require 'rubyonacid/factories/example'

#This factory chooses notes, play durations, etc.
factory = RubyOnAcid::ExampleFactory.new
    
#This factory randomly resets the meta factory.
@resetter = RubyOnAcid::SkipFactory.new(:odds => 0.99999)

File.open("raw_audio.dat", "w") do |file|
  loop do
    channel_count = factory.get(:channel_count, :max => 3).to_i
    channel_count.times do |i|
      file.putc factory.get(i, :min => 100, :max => 175).to_i
    end
    if @resetter.boolean(:reset)
      factory.reset_assignments
    end
  end
end
