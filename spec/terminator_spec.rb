require_relative '../lib/dunmanifestin/terminator'

describe Terminator do
  describe '#address' do
    let(:genre)       { 'spooky-ghost-opera' }
    let(:phrase)      { 'I like [adjective] [animal.plural]!' }
    let(:demands)     { {genre: genre, phrase: phrase} }
    let(:list_loader) { double :get_yer_lists }
    let(:shell)       { double :shell }

    let(:terminator) do
      Terminator.new list_loader: list_loader, shell: shell
    end

    before do
      allow(shell).to receive(:puts)
      allow(list_loader).to receive(:load)
    end

    it 'loads lists from the genre' do
      expect(list_loader).to receive(:load).with genre
      terminator.address demands
    end

    it 'prints stuff' do
      expect(shell).to receive(:puts)
      terminator.address demands
    end
  end
end
