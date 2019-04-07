require_relative '../lib/dunmanifestin/array'

describe Array do
  describe 'constrained_sample' do
    subject { ["foo","bar","baz"] }

    it 'respects the provided randoms when sampling' do
      expect(subject.constrained_sample(
        meta_random: Random.new(1),
        randoms: [Random.new(2), Random.new(2)]
      )).to eql("foo")

      expect(subject.constrained_sample(
        meta_random: Random.new(1),
        randoms: [Random.new(3), Random.new(3)]
      )).to eql("baz")
    end

    it 'uses true random when no meta_random is supplied' do
      sample = subject.constrained_sample(
        randoms: [Random.new(2), Random.new(2)]
      )
      expect(subject).to include(sample)
    end
  end

  describe 'even_elements' do
    it 'returns nothing for an empty array' do
      expect([].even_elements).to eq []
    end

    it 'returns the zeroth item' do
      expect([1].even_elements).to eq [1]
    end

    it 'returns even-indexed items' do
      expect([1, 2, 4, 8, 16].even_elements).to eq [1, 4, 16]
    end
  end

  describe 'odd_elements' do
    it 'returns nothing for an empty array' do
      expect([].odd_elements).to eq []
    end

    it 'does not return the zeroth item' do
      expect([1].odd_elements).to eq []
    end

    it 'returns odd-indexed items' do
      expect([1, 2, 4, 8, 16].odd_elements).to eq [2, 8]
    end
  end
end
