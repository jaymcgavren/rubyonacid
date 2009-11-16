require 'rubygems'
require 'rubyonacid/factories/meta'
require 'rubyonacid/factories/constant'
require 'rubyonacid/factories/flash'
require 'rubyonacid/factories/loop'
require 'rubyonacid/factories/modulo'
require 'rubyonacid/factories/random'
require 'rubyonacid/factories/repeat'
require 'rubyonacid/factories/sine'
require 'rubyonacid/factories/skip'

random_factory = RubyOnAcid::RandomFactory.new

#The MetaFactory assigns factories to requested value types.
factory = RubyOnAcid::MetaFactory.new
#Loop factories loop from 0.0 to 1.0 (or 1.0 to 0.0 if the increment value is negative).
factory.factory_pool << RubyOnAcid::LoopFactory.new(0.01)
factory.factory_pool << RubyOnAcid::LoopFactory.new(-0.01)
factory.factory_pool << RubyOnAcid::LoopFactory.new(0.001)
factory.factory_pool << RubyOnAcid::LoopFactory.new(-0.001)
#Constant factories always return the same value,
factory.factory_pool << RubyOnAcid::ConstantFactory.new(rand)
factory.factory_pool << RubyOnAcid::ConstantFactory.new(rand)
factory.factory_pool << RubyOnAcid::FlashFactory.new(rand(100))
#Sine factories produce a "wave" pattern.
factory.factory_pool << RubyOnAcid::SineFactory.new(0.1)
factory.factory_pool << RubyOnAcid::SineFactory.new(-0.1)
factory.factory_pool << RubyOnAcid::SineFactory.new(0.01)
factory.factory_pool << RubyOnAcid::SineFactory.new(-0.01)
factory.factory_pool << RubyOnAcid::RepeatFactory.new(
  RubyOnAcid::LoopFactory.new(random_factory.within(:increment, -0.1, 0.1)),
  random_factory.within(:interval, 2, 100)
)
factory.factory_pool << RubyOnAcid::RepeatFactory.new(
  RubyOnAcid::SineFactory.new(random_factory.within(:increment, -0.1, 0.1)),
  random_factory.within(:interval, 2, 100)
)
factory.factory_pool << RubyOnAcid::ModuloFactory.new(RubyOnAcid::LoopFactory.new(0.00001))

#A skip factory, in charge of randomly resetting the meta factory.
@resetter = RubyOnAcid::SkipFactory.new(0.999)


require 'midiator'

midi = MIDIator::Interface.new
midi.autodetect_driver

loop do
  midi.play(
    factory.within(:note, 10, 127).to_i,
    factory.within(:duration, 0, 0.1),
    factory.within(:channel, 0, 10).to_i,
    factory.within(:velocity, 0, 127)
  )
  factory.reset_assignments if @resetter.boolean(:reset)
end
