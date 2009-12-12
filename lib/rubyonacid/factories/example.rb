require 'rubyonacid/factories/all'

module RubyOnAcid

#A preconfigured factory with all the bells and whistles.
#Use this if you want to get up and running quickly and don't need to tweak the settings.
class ExampleFactory < MetaFactory

  
  def initialize
    super
    @factory_pool = create_factories
  end


  private

  
    def create_factories
      
      random_factory = RubyOnAcid::RandomFactory.new

      source_factories = []
      
      5.times do
        factory = RubyOnAcid::LoopFactory.new
        factory.interval = random_factory.get(:increment, :min => -0.1, :max => 0.1)
        source_factories << factory
      end
      3.times do
        factory = RubyOnAcid::ConstantFactory.new
        factory.value = random_factory.get(:constant)
        source_factories << factory
      end
      source_factories << RubyOnAcid::FlashFactory.new(
        random_factory.get(:interval, :max => 100)
      )
      4.times do
        factory = RubyOnAcid::SineFactory.new
        factory.interval = random_factory.get(:increment, :min => -0.1, :max => 0.1)
        source_factories << factory
      end
      2.times do
        factory = RubyOnAcid::RepeatFactory.new
        factory.repeat_count = random_factory.get(:interval, :min => 2, :max => 100)
        factory.source_factory = source_factories[rand(source_factories.length)]
        source_factories << factory
      end
      combination_factory = RubyOnAcid::CombinationFactory.new
      2.times do
        combination_factory.source_factories << source_factories[rand(source_factories.length)]
      end
      source_factories << combination_factory
      source_factories << RubyOnAcid::RandomWalkFactory.new(0.1)
      
      source_factories

    end


end

end