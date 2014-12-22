require_relative '../lib/dunmanifestin/phrase'

describe Phrase do
  describe '.list' do
    it 'is sampleable' do
      expect(Phrase.list).to respond_to :sample
    end

    it 'sets the list of patterns for the phrase' do
      animal = Class.new(Phrase)

      animal.list [
        'turtle'
      ]

      expect(animal.new.to_s).to eq 'turtle'
    end
  end

  class Phrase::Animal < Phrase
    list ['frog']
  end

  it 'interpolates' do
    phrase = Phrase.new('I love this [animal].')
    expect(phrase.to_s).to eq('I love this frog.')
  end

  it 'pluralizes' do
    phrase = Phrase.new 'I adore these [animal.plural]!'
    expect(phrase.to_s).to eq('I adore these frogs!')
  end

  it 'articulates' do
    phrase = Phrase.new 'I can get along with [animal.article].'
    expect(phrase.to_s).to eq('I can get along with a frog.')
  end

  describe 'delegating the plural inflection to consituents' do
    class Phrase::Vestment < Phrase
      list ['suit']
    end

    class Phrase::WoolenVestment < Phrase
      list ['[vestment#plural] made of wool']
    end

    class Phrase::DressyAnimal < Phrase
      list ['[animal#plural] wearing [vestment.article#plural]']
    end

    class Phrase::ItchyAnimal < Phrase
      list ['[animal#plural] wearing [woolenVestment#plural]']
    end

    class Phrase::GroupOfAnimals < Phrase
      list ['a posse of [itchyAnimal#plural]']
    end

    it 'works' do
      phrase = Phrase.new 'OMG, there are so many [dressyAnimal.plural] at this party'
      expect(phrase.to_s).to eq('OMG, there are so many frogs wearing suits at this party')
    end

    it 'does not pluralize anything with no plural requested' do
      phrase = Phrase.new 'One lonely [dressyAnimal]'
      expect(phrase.to_s).to eq('One lonely frog wearing a suit')
    end

    it 'recurses' do
      phrase = Phrase.new 'Ten [itchyAnimal.plural]'
      expect(phrase.to_s).to eq('Ten frogs wearing suits made of wool')
    end
  end
end
