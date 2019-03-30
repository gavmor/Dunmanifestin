require_relative '../lib/dunmanifestin/list_loader'
require 'tmpdir'

describe ListLoader do
  let(:palette_name) { 'root.dun' }
  let(:default_palettes) do
    %w(doctrinist adverb abstraction root superlative verb)
  end
  let(:palette_dir) { Dir.mktmpdir }
  let(:palette_doc) do
<<-TXT
|root
cat
frog
chicken
TXT
  end

  before do
    open(File.join(palette_dir, palette_name+'.pal'), 'w') { |f| f.puts palette_doc }
    allow(Palette).to receive(:expose)
  end

  describe '.load' do
    it 'exposes the default genre' do
      default_palettes.each do |palette|
        expect(Palette).to receive(:expose)
          .with(something_including(palette))
      end

      ListLoader.load
    end

    it 'exposes the given genre' do
      expect(Palette).to receive(:expose)
        .with(something_including(palette_name))

      ListLoader.load palette_dir
    end

    context 'when given multiple genres' do

      it 'exposes each in turn' do
        expect(Palette).to receive(:expose)
          .with(something_including(palette_name)).twice

        ListLoader.load [palette_dir,palette_dir].join(':')
      end
    end
  end
end

RSpec::Matchers.define :something_including do |x|
  match { |actual| actual.include?(x) }
end
