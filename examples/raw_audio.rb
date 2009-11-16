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

def generate_factories

  random_factory = RubyOnAcid::RandomFactory.new

  factory_pool = []

  #Loop factories loop from 0.0 to 1.0 (or 1.0 to 0.0 if the increment value is negative).
  factory_pool << RubyOnAcid::LoopFactory.new(random_factory.within(:increment, -0.01, 0.01))
  #Constant factories always return the same value,
  factory_pool << RubyOnAcid::ConstantFactory.new(rand)
  factory_pool << RubyOnAcid::ConstantFactory.new(rand)
  factory_pool << RubyOnAcid::FlashFactory.new(rand(100))
  #Sine factories produce a "wave" pattern.
  factory_pool << RubyOnAcid::SineFactory.new(random_factory.within(:increment, -0.01, 0.01))
  factory_pool << RubyOnAcid::RepeatFactory.new(
    RubyOnAcid::LoopFactory.new(random_factory.within(:increment, -0.1, 0.1)),
    random_factory.within(:interval, 2, 100)
  )
  factory_pool << RubyOnAcid::RepeatFactory.new(
    RubyOnAcid::SineFactory.new(random_factory.within(:increment, -0.1, 0.1)),
    random_factory.within(:interval, 2, 100)
  )
  factory_pool << RubyOnAcid::ModuloFactory.new(RubyOnAcid::LoopFactory.new(0.00001))
  factory_pool
end

#A skip factory, in charge of randomly resetting the meta factory.
@resetter = RubyOnAcid::SkipFactory.new(0.99995)

factory = RubyOnAcid::MetaFactory.new
factory.factory_pool = generate_factories
File.open("raw_audio.dat", "w") do |file|
  loop do
    channel_count = factory.within(:chanel_count, 0, 3).to_i
    channel_count.times do |i|
      file.putc factory.within(i, 0, 255).to_i
    end
    if @resetter.boolean(:reset)
      factory.factory_pool = generate_factories
      factory.reset_assignments
    end
  end
end
