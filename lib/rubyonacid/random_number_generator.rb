module RubyOnAcid
  #Mixin that provides a generate_random_number method.
  #Expects the class including it to define a rng_seed method.
  module RandomNumberGenerator

    private def generate_random_number
      @random_number_generator ||= Random.new(rng_seed)
      @random_number_generator.rand
    end

  end
end
