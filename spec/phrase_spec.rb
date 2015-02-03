require_relative '../lib/dunmanifestin/phrase'

describe Phrase do
  describe '.list' do
    let(:multiline_phrase) { "foo\nbar" }

    it 'does not split a multiline phrase' do
      expect(Phrase.list(multiline_phrase, true)).to match_array([multiline_phrase])
    end

    it 'is sampleable' do
      expect(Phrase.list).to respond_to :sample
    end

    it 'sets the list of patterns for the phrase' do
      animal = Class.new(Phrase)
      animal.list [ 'turtle' ]
      expect(animal.new.to_s).to eq 'turtle'
    end
  end

  class Phrase::TestAnimal < Phrase
    list ['frog']
  end

  it 'interpolates' do
    phrase = Phrase.new('I love this [testAnimal].')
    expect(phrase.to_s).to eq('I love this frog.')
  end

  it 'pluralizes' do
    phrase = Phrase.new 'I adore these [testAnimal.plural]!'
    expect(phrase.to_s).to eq('I adore these frogs!')
  end

  describe '.titleize' do
    class Phrase::Book < Phrase
      list ['a tale of two cities']
    end

    it 'works' do
      phrase = Phrase.new 'I just read [book.titleize].'
      expect(phrase.to_s).to eq 'I just read A Tale Of Two Cities.'
    end
  end

  it 'articulates' do
    phrase = Phrase.new 'I can get along with [testAnimal.article].'
    expect(phrase.to_s).to eq('I can get along with a frog.')
  end

  describe 'delegating the plural inflection to consituents' do
    class Phrase::TestVestment < Phrase
      list ['suit']
    end

    class Phrase::TestWoolenVestment < Phrase
      list ['[testVestment#plural] made of wool']
    end

    class Phrase::TestDressyAnimal < Phrase
      list ['[testAnimal#plural] wearing [testVestment.article#plural]']
    end

    class Phrase::TestItchyAnimal < Phrase
      list ['[testAnimal#plural] wearing [testWoolenVestment#plural]']
    end

    it 'works' do
      phrase = Phrase.new 'OMG, there are so many [testDressyAnimal.plural] at this party'
      expect(phrase.to_s).to eq('OMG, there are so many frogs wearing suits at this party')
    end

    it 'does not pluralize anything with no plural requested' do
      phrase = Phrase.new 'One lonely [testDressyAnimal]'
      expect(phrase.to_s).to eq('One lonely frog wearing a suit')
    end

    it 'recurses' do
      phrase = Phrase.new 'Ten [testItchyAnimal.plural]'
      expect(phrase.to_s).to eq('Ten frogs wearing suits made of wool')
    end
  end
end
