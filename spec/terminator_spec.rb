require_relative '../lib/dunmanifestin/terminator'
require 'tempfile'

describe Terminator do
  describe '#address' do
    let(:genre)       { 'spooky-ghost-opera' }
    let(:phrase)      { 'I like [adjective] [animal.plural]!' }
    let(:demands)     { {genre: genre, phrase: phrase} }
    let(:shell)       { double :shell }
    let(:multiline_document) do
<<-TXT
Multiple
Line

Document
TXT
    end

    let(:terminator) do
      Terminator.new shell: shell
    end

    before do
      allow(shell).to receive(:puts)
    end

    context 'when given a file path' do
      let(:file) do
        file = Tempfile.new('phrasing')
        file.write(multiline_document)
        file.close
        file.path
      end

      let(:demands) { {file: file} }

      it 'prints stuff' do
        expect(shell).to receive(:puts).with("#{multiline_document}\n")
        terminator.address demands
      end
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

        it 'prints the words and some question marks' do
          expect(shell).to receive(:puts).with("I know {garbage ??} well!\n")
          terminator.address demands
        end
      end
    end

    context 'when passed a seed' do
      let(:demands) {{coarse_seed: 12, fine_seed: 10}}

      it 'works' do
        terminator.address demands
      end
    end
  end
end
