require_relative '../lib/dunmanifestin/churn'

describe Churn do
  it 'samples from large set of items when novelty is high' do
    c = Churn.new novelty: 10000
    sampled = 50.times.map { c.sample { rand.*(10000).floor } }
    expect(sampled.uniq.length).to be > 47
  end

  it 'samples from a limited set of items when novelty is low' do
    c = Churn.new novelty: 1

    sampled = 50.times.map { c.sample { rand.*(1000).floor } }
    expect(sampled.uniq.length).to be < 20
  end

  it 'can be forced to generate a new item' do
    c = Churn.new novelty: 1

    existing = 50.times.map { c.generate { rand.*(1_000_000_000).floor } }
    new = c.generate { rand.*(1_000_000_000).floor }
    expect(existing).not_to include new
  end

  it 'may choose to "generate" an item that was previously coined by sample()' do
    # This detail supports the Churn's use as a generator of
    # recurring characters. A character specified with a
    # phrase variable like [person:recur] should be allowed
    # to be generated (once) by [person].
    c = Churn.new novelty: 1

    existing = 50.times.map { c.sample { rand.*(1_000_000_000).floor }}
    new = 5.times.map { c.generate { rand.*(1_000_000_000).floor }}
    expect(new & existing).not_to be_empty
  end

  context 'when novelty is 0' do
    let (:c) { Churn.new novelty: 0 }
    it 'generates' do
      expect(c.generate { rand.*(100).floor }).to be_a Numeric
    end

    it 'samples' do
      expect(c.sample { rand.*(100).floor }).to be_a Numeric
    end
  end
end
