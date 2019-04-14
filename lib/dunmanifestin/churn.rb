class Churn
  # A churn is a data structure that stores a set of things.
  # You can randomly pick one of those things by calling its
  # sample() method.
  #
  # The wrinkle is that the set of sampleable things is not
  # closed. The churn will sometimes, at random, generate a
  # totally new item. You can also explicitly request a
  # novel item by calling generate(). Any new items
  # generated are added to the churn and may be picked on
  # future calls to sample().
  #
  # Control how often the churn generates new things using
  # the novelty: parameter to initialize().

  def initialize novelty:
    @novelty = novelty
    @generated = 0
    @slots = {}
  end

  def sample
    return yield if @novelty == 0
    r = (rand * (@novelty + @slots.length)).floor
    @slots[r] ||= yield
  end

  def generate
    return yield if @novelty == 0
    @slots[@generated] ||= yield
    value = @slots[@generated]
    @generated += 1
    value
  end
end
