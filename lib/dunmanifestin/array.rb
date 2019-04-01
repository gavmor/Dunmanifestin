class Array
  def constrained_sample(n=nil, provider)
    self.sample(
      1,
      random: provider.fetch(:randoms).sample(
        random: provider.fetch(:meta_random, Random.new)
      )
    ).pop
  end
end
