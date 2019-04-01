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
end
