require 'rubygems'
require 'rubyonacid/factories/meta'
require 'rubyonacid/factories/combination'
require 'rubyonacid/factories/constant'
require 'rubyonacid/factories/flash'
require 'rubyonacid/factories/loop'
require 'rubyonacid/factories/random'
require 'rubyonacid/factories/repeat'
require 'rubyonacid/factories/sine'
require 'rubyonacid/factories/skip'


def create_factory
  
  random_factory = RubyOnAcid::RandomFactory.new
  
  source_factories = []
  #Loop factories loop from 0.0 to 1.0 (or 1.0 to 0.0 if the increment value is negative).
  5.times do
    factory = RubyOnAcid::LoopFactory.new
    factory.interval = random_factory.get(:increment, :min => -0.1, :max => 0.1)
    source_factories << factory
  end
  #Constant factories always return the same value.
  3.times do
    factory = RubyOnAcid::ConstantFactory.new
    factory.value = random_factory.get(:constant)
    source_factories << factory
  end
  source_factories << RubyOnAcid::FlashFactory.new(rand(100))
  #Sine factories produce a "wave" pattern.
  4.times do
    factory = RubyOnAcid::SineFactory.new
    factory.interval = random_factory.get(:increment, :min => -0.1, :max => 0.1)
    source_factories << factory
  end
  #A RepeatFactory wraps another factory, queries it, and repeats the same value a certain number of times.
  2.times do
    factory = RubyOnAcid::RepeatFactory.new
    factory.repeat_count = random_factory.get(:interval, :min => 2, :max => 100)
    factory.source_factory = source_factories[rand(source_factories.length)]
    source_factories << factory
  end
  #A CombinationFactory combines the values of two or more other factories.
  combination_factory = RubyOnAcid::CombinationFactory.new
  2.times do
    combination_factory.source_factories << source_factories[rand(source_factories.length)]
  end
  source_factories << combination_factory
  
  #The MetaFactory pulls requested value types from the other factories.
  meta_factory = RubyOnAcid::MetaFactory.new
  meta_factory.factory_pool = source_factories
  
  meta_factory
  
end

factory = create_factory

#A skip factory, in charge of randomly resetting the meta factory.
@resetter = RubyOnAcid::SkipFactory.new(0.999)


require 'midiator'

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
