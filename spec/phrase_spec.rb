require_relative '../lib/dunmanifestin/phrase'

describe Phrase do
  describe '.list' do
    it 'is sampleable' do
      expect(Phrase.list).to respond_to :sample
    end
  end

  describe '.new' do
    let(:animals) { ['frog'] }

    it 'works' do
      Phrase.new 'I am the very model of me.'
    end

    it 'interpolates' do
      phrase = Phrase.new('I love this [animal].')
      # expect(phrase.to_s).to eq('I love this frog.')
    end

    it 'pluralizes' do
      phrase = Phrase.new 'I adore these [animal.plural]!'
      # expect(phrase.to_s).to eq('I love these frogs.')
    end

    it 'articulates' do
      phrase = Phrase.new 'I can get along with [animal.article].'
      # expect(phrase.to_s).to eq('I can get along with a frog.')
    end
  end
end
