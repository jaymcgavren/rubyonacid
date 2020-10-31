require 'rubyonacid/factories/all'
require 'rubyonacid/random_number_generator'

module RubyOnAcid

#A preconfigured factory with all the bells and whistles.
#Use this if you want to get up and running quickly and don't need to tweak the settings.
class ExampleFactory < MetaFactory
  include RubyOnAcid::RandomNumberGenerator

  #The numeric seed used for the random number generator.
  attr_accessor :rng_seed

  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :rng_seed => Random.new_seed
  def initialize(options = {})
    super
    @rng_seed = options[:rng_seed] || Random.new_seed
    self.source_factories = generate_factories
  end

  def generate_factories
    
    random_factory = RubyOnAcid::RandomFactory.new(rng_seed: rng_seed)

    factories = []
    
    5.times do
      factory = RubyOnAcid::LoopFactory.new
      factory.interval = random_factory.get(:increment, :min => -0.1, :max => 0.1)
      factories << factory
    end
    3.times do
      factory = RubyOnAcid::ConstantFactory.new
      factory.value = random_factory.get(:constant)
      factories << factory
    end
    factories << RubyOnAcid::FlashFactory.new(
      :interval => random_factory.get(:interval, :max => 100)
    )
    2.times do
      factories << RubyOnAcid::LissajousFactory.new(
        :interval => random_factory.get(:interval, :max => 10.0),
        :scale => random_factory.get(:scale, :min => 0.1, :max => 2.0)
      )
    end
    factories << RubyOnAcid::RandomWalkFactory.new(
      :interval => random_factory.get(:interval, :max => 0.1),
      :rng_seed => rng_seed
    )
    4.times do
      factory = RubyOnAcid::SineFactory.new
      factory.interval = random_factory.get(:increment, :min => -0.1, :max => 0.1)
      factories << factory
    end
    2.times do
      factory = RubyOnAcid::RepeatFactory.new
      factory.repeat_count = random_factory.get(:interval, :min => 2, :max => 100)
      factory.source_factories << random_element(factories)
      factories << factory
    end
    2.times do
      factories << RubyOnAcid::RoundingFactory.new(
        :source_factories => [random_element(factories)],
        :nearest => random_factory.get(:interval, :min => 0.1, :max => 0.5)
      )
    end
    combination_factory = RubyOnAcid::CombinationFactory.new
    combination_factory.constrain_mode = random_factory.choose(:constrain_mode,
      CombinationFactory::CONSTRAIN,
      CombinationFactory::WRAP,
      CombinationFactory::REBOUND
    )
    combination_factory.operation = random_factory.choose(:operation,
      CombinationFactory::ADD,
      CombinationFactory::SUBTRACT,
      CombinationFactory::MULTIPLY,
      CombinationFactory::DIVIDE
    )
    2.times do
      combination_factory.source_factories << random_element(factories)
    end
    factories << combination_factory
    weighted_factory = RubyOnAcid::WeightedFactory.new
    2.times do
      source_factory = random_element(factories)
      weighted_factory.source_factories << source_factory
      weighted_factory.weights[source_factory] = generate_random_number
    end
    factories << weighted_factory
    proximity_factory = RubyOnAcid::ProximityFactory.new
    2.times do
      proximity_factory.source_factories << random_element(factories)
    end
    factories << proximity_factory
8.times do
    attraction_factory = RubyOnAcid::AttractionFactory.new(
      :attractor_factory => random_element(factories)
    )
    attraction_factory.source_factories << random_element(factories)
    factories << attraction_factory
end
  
    factories
    
  end
  
  private
    
    def random_element(array)
      array[generate_random_number(array.length)]
    end


end

end
