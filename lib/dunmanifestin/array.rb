class Array
  NUM_DEFAULT_REGIONS = 100000
  RECCURENCES = 50

  class << self
    attr_accessor :coarse_seed, :fine_seed

    def meta_random
      @meta_random ||= @fine_seed ? Random.new(@fine_seed) : Random.new
    end

    def randoms
      @randoms ||= RECCURENCES.times.map do
        Random.new(@coarse_seed || rand(NUM_DEFAULT_REGIONS))
      end
    end
  end

  def constrained_sample(randoms: Array.randoms, meta_random: Array.meta_random)
    self.sample(
      1,
      random: randoms.sample(1, random: meta_random).pop
    ).pop
  end
end
