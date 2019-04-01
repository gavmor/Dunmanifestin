require_relative '../lib/dunmanifestin/array'

describe Array do
  describe 'constrained_sample' do
    subject { ["foo","bar","baz"] }

    it 'picks from a handful of seeds before making its selection' do
      sample = ["foo","bar","baz"].constrained_sample(
        1,
        meta_random: Random.new(1),
        randoms: [Random.new(2), Random.new(2)]
      )
      expect(sample).to eql("foo")
      expect(sample).to eql("foo")
      expect(sample).to eql("foo")

      sample = ["foo","bar","baz"].constrained_sample(
        1,
        meta_random: Random.new(1),
        randoms: [Random.new(3), Random.new(3)]
      )

      expect(sample).to eql("baz")
      expect(sample).to eql("baz")
      expect(sample).to eql("baz")
    end

    it 'uses true random when no meta_random is supplied' do
      sample = subject.constrained_sample(
        1,
        randoms: [Random.new(2), Random.new(2)]
      )
      expect(subject).to include(sample)
    end
  end
end
