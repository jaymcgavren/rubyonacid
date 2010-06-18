require 'rubyonacid/factories/all'

module RubyOnAcid

#A preconfigured factory with all the bells and whistles.
#Use this if you want to get up and running quickly and don't need to tweak the settings.
class ExampleFactory < MetaFactory

  
  #Takes a hash with all keys supported by Factory.
  def initialize(options = {})
    super
    reset_assignments
  end
  
  def reset_assignments
    super
    self.source_factories = create_factories
  end
  

  private

  
    def create_factories
      
      random_factory = RubyOnAcid::RandomFactory.new

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
        :interval => random_factory.get(:interval, :max => 0.1)
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
      2.times do
        combination_factory.source_factories << random_element(factories)
      end
      factories << combination_factory
      proximity_factory = RubyOnAcid::ProximityFactory.new
      2.times do
        proximity_factory.source_factories << random_element(factories)
      end
      factories << proximity_factory
    
      factories
    end
    
    def random_element(array)
      array[rand(array.length)]
    end


end

end