require_relative '../lib/dunmanifestin/list_loader'

describe ListLoader do
  describe '.load' do
    it 'loads phrases from the given genre' do
      ListLoader.load 'sexy-horror'
    end
  end
end
