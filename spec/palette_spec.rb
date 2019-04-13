require_relative '../lib/dunmanifestin/palette'

describe Palette do
  it 'has a name, which is the string after the pipe' do
    p = Palette.new(<<-EOF, 'characters.pal')
|person
Hamlet
    EOF

    expect(p.name).to eq 'person'
  end

  it 'defaults its name to the base name of the palette file' do
    p = Palette.new(<<-EOF, '/foo/bar/characters.pal')
Hamlet
    EOF
    expect(p.name).to eq 'characters'
  end

  it 'ignores extra whitespace before the title' do
    p = Palette.new(<<-EOF, '/foo/bar/characters.pal')


|person
Hamlet
    EOF

    expect(p.name).to eq 'person'
  end

  it 'selects a phrase at random' do
    palette = Palette.new(<<-EOF, 'characters.pal')
|person
Hamlet
Ophelia
    EOF

    selections = 50.times.map { palette.sample nil }
    expect(selections).to include 'Hamlet'
    expect(selections).to include 'Ophelia'
  end

  it 'ignores comments' do
    palette = Palette.new(<<-EOF, 'characters.pal')
|person
// prince of Denmark
Hamlet
Ophelia // daughter of Polonius
    EOF

    selections = 50.times.map { palette.sample nil }
    expect(selections.uniq.sort).to eq ['Hamlet', 'Ophelia']
  end

  it 'ignores lines with only whitespace' do
    palette_text = "|person\n  \nErnie"
    palette = Palette.new(palette_text, 'characters.pal')
    selections = 50.times.map { palette.sample nil }
    expect(selections.uniq.sort).to eq ['Ernie']
  end

  it 'ignores empty lines' do
    palette_text = "|person\n\n\nBert\n\n"
    palette = Palette.new(palette_text, 'characters.pal')
    selections = 50.times.map { palette.sample nil }
    expect(selections.uniq.sort).to eq ['Bert']
  end

  it 'allows shorthand for duplicate elements' do
    palette = Palette.new(<<-EOF, 'tropes.pal')
|trope
5@loose cannon rookie cop
rogue whac-a-mole game terrorizing Boston
    EOF

    selections = 100.times.map { palette.sample nil }
    expect(selections.select { |s| s == 'loose cannon rookie cop' }.length).to be > 70
    expect(selections).to include 'rogue whac-a-mole game terrorizing Boston'
  end
end
