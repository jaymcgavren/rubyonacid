require 'rubyonacid/factories/all'

#This method takes any Factory and uses it to determine the length of lines to print.
def make_lines(factory)
  #Show what factory we're working with.
  puts factory.class.name
  10.times do
    #Get the length of the line.
    #The :max option scales the returned length to be between 0 and 79.
    line_length = factory.get(:length, :max => 79)
    puts "|" * line_length
  end
end

#Random factories generate a random number between 0 and 1.
make_lines RubyOnAcid::RandomFactory.new

#Random walk factories increase or decrease the prior return value within a given amount.
make_lines RubyOnAcid::RandomWalkFactory.new(0.1)

#Loop factories loop from 0 to 1 (or 1 to 0 if the increment value is negative).
make_lines RubyOnAcid::LoopFactory.new(0.2)
make_lines RubyOnAcid::LoopFactory.new(-0.2)

#Constant factories always return the same value,
make_lines RubyOnAcid::ConstantFactory.new(0.5)

#This flash factory returns 0 twice, then 1 twice, then 0 twice, etc.
make_lines RubyOnAcid::FlashFactory.new(2)

#Sine factories produce a "wave" pattern.
make_lines RubyOnAcid::SineFactory.new(0.3)

#A RepeatFactory wraps another factory, queries it, and repeats the same value a certain number of times.
factory_to_repeat = RubyOnAcid::LoopFactory.new(0.3)
make_lines RubyOnAcid::RepeatFactory.new(factory_to_repeat, 2)

#A CombinationFactory combines the values of two or more other factories.
factories_to_combine = [
  RubyOnAcid::SineFactory.new(0.1),
  RubyOnAcid::SineFactory.new(-0.2)
]
make_lines RubyOnAcid::CombinationFactory.new(:source_factories => factories_to_combine)

#A RoundingFactory rounds values from a source factory to a multiple of a given number.
factory_to_round = RubyOnAcid::LoopFactory.new(0.1)
make_lines RubyOnAcid::RoundingFactory.new(factory_to_round, 0.25)
