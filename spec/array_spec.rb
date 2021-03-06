require_relative '../lib/dunmanifestin/array'

describe Array do
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
