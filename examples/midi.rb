require 'rubygems'
require 'rubyonacid/factories/example'

#This factory chooses notes, play durations, etc.
factory = RubyOnAcid::ExampleFactory.new
    
#This factory randomly resets the meta factory.
@resetter = RubyOnAcid::SkipFactory.new(0.999)

begin
  require 'midiator'
rescue LoadError
  raise "It appears that MIDIator is not installed. 'sudo gem install midiator' to install it."
end

midi = MIDIator::Interface.new
midi.autodetect_driver

loop do
  midi.play(
    factory.get(:note, :min => 10, :max => 127).to_i,
    factory.get(:duration, :max => 0.1),
    factory.get(:channel, :max => 10).to_i,
    factory.get(:velocity, :max => 127)
  )
  factory.reset_assignments if @resetter.boolean(:reset)
end
