NUM_DEFAULT_REGIONS = 100000
RECCURENCES = 5
COARSE_SEED ||= rand(NUM_DEFAULT_REGIONS)
FINE_SEED ||= nil

META_RANDOM = FINE_SEED ? Random.new(FINE_SEED) : Random.new
RANDOMS = RECCURENCES.times.map { Random.new(COARSE_SEED) }

class Array
  def constrained_sample(randoms: RANDOMS, meta_random: META_RANDOM)
    self.sample(
      1,
      random: randoms.sample(1, random: meta_random).pop
    ).pop
  end
end
