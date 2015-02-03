require_relative '../lib/dunmanifestin/terminator'
require 'tempfile'

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

    context 'when given a file path' do
      let(:file) do
        file = Tempfile.new('phrasing')
        file.write("hello world")
        file.close
        file.path
      end
      let(:demands) { {file: file} }

      it 'prints stuff' do
        expect(shell).to receive(:puts).with("hello world\n")
        terminator.address demands
      end
    end

    it 'loads lists from the genre' do
      expect(list_loader).to receive(:load).with genre
      terminator.address demands
    end

    it 'prints stuff' do
      expect(shell).to receive(:puts)
      terminator.address demands
    end

    context 'when the given phrase requests a missing item' do
      let(:phrase) { 'I know [beelzebub] well!' }

      it 'prints the word and some question marks' do
        expect(shell).to receive(:puts).with("I know {beelzebub ??} well!\n")
        terminator.address demands
      end

      context 'with an article' do
        let(:phrase) { 'I know [garbage.article] well!' }

        xit 'prints the words and some question marks' do
          expect(shell).to receive(:puts).with("I know {garbage.article ??} well!")
          terminator.address demands
        end
      end
    end
  end
end
