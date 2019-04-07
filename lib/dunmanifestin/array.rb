require_relative 'integer'

class Array
  class << self
    attr_accessor :coarse_seed, :fine_seed, :diversity, :recurrences

    def meta_random
      @meta_random ||= @fine_seed ? Random.new(@fine_seed) : Random.new
    end

    def randoms
      @coarse_seed ||= meta_random.rand(Integer::MAX)
      @recurrences ||= 500
      @randoms ||= @recurrences.times.map do |i|
        Random.new(@coarse_seed + (i % (@diversity||Integer::MAX)))
      end
    end
  end

  def constrained_sample(randoms: Array.randoms, meta_random: Array.meta_random)
    # $count ||= 1
    # p $count += 1
    self.sample(
      1,
      random: randoms.sample(1, random: meta_random).pop
    ).pop
  end

  def even_elements
    select.each_with_index { |_, i| i.even? }
  end

  def odd_elements
    select.each_with_index { |_, i| i.odd? }
  end
end
