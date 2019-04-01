class Array
  def constrained_sample(provider)
    self.sample(
      1,
      random: provider.fetch(:randoms).sample(
        random: provider.fetch(:meta_random, Random.new)
      )
    ).pop
  end
end
