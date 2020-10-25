module RubyOnAcid
  #Mixin that provides a generate_random_number method.
  #Expects the class including it to define a rng_seed method.
  module RandomNumberGenerator

    #Accepts an argument (or no arguments) just like Random#rand.
    private def generate_random_number(*args)
      @random_number_generator ||= Random.new(rng_seed)
      @random_number_generator.rand(*args)
    end

  end
end
