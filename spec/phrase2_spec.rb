require_relative '../lib/dunmanifestin/genre'
require_relative '../lib/dunmanifestin/palette'
require_relative '../lib/dunmanifestin/phrase'

describe Phrase do
  let(:frog_prince) do
    animal_palette = double :animal_palette,
      sample: Phrase.new('frog')

    vestment_palette = double :vestment_palette,
      sample: Phrase.new('suit')

    classy_animal_palette = double :classy_animal_palette,
      sample: Phrase.new('[animal#article#plural] wearing [vestment#article#plural]')


    genre = 'dummy genre'
    allow(genre).to receive(:palette_named).with('animal')      .and_return animal_palette
    allow(genre).to receive(:palette_named).with('vestment')    .and_return vestment_palette
    allow(genre).to receive(:palette_named).with('classyAnimal').and_return classy_animal_palette

    genre
  end

  let(:dickens) do
    genre = 'dummy genre'
    book_palette = 'dummy palette'
    allow(genre).to receive(:palette_named).with('book').and_return book_palette
    allow(book_palette).to receive(:sample).and_return Phrase.new 'a tale of two cities'
    genre
  end

  it 'echoes back unadorned text' do
    expect(Phrase.new('Mae govannen').reify nil).to eq 'Mae govannen'
  end

  it 'references other palettes in the genre via variables' do
    expect(Phrase.new('I love this [animal]!').reify frog_prince).to eq 'I love this frog!'
  end

  it 'pluralizes' do
    expect(Phrase.new('I adore these [animal.plural]!').reify frog_prince).to eq 'I adore these frogs!'
  end

  it 'possessivizes' do
    expect(Phrase.new('I love this [animal.possessive] legs!').reify frog_prince).to eq "I love this frog's legs!"
  end

  it 'possessivizes plurals' do
    expect(Phrase.new('I love these [animal.possessive.plural] legs!').reify frog_prince).to eq "I love these frogs' legs!"
  end

  it 'capitalizes' do
    expect(Phrase.new('[book.capitalize]').reify dickens).to eq "A tale of two cities"
  end

  it 'titleizes' do
    expect(Phrase.new('I just read [book.titleize]').reify dickens).to eq "I just read A Tale Of Two Cities"
  end

  it 'articulates' do
    expect(Phrase.new('I do love me [animal.article]!').reify frog_prince).to eq "I do love me a frog!"
    expect(Phrase.new('I do love me some [animal.article.plural]!').reify frog_prince).to eq "I do love me some frogs!"
    expect(Phrase.new('I do love me [book.titleize.article]!').reify dickens).to eq "I do love me An A Tale Of Two Cities!"
  end

  it 'delegates inflections' do
    expect(Phrase.new('[classyAnimal.article]').reify frog_prince).to eq 'a frog wearing a suit'
    expect(Phrase.new('[classyAnimal.plural]').reify frog_prince).to eq 'frogs wearing suits'
  end

  it 'renders a placeholder when a variable references a nonexistent palette' do
    genre = Genre.new ['/tmp/i-do-not-exist']
    expect(Phrase.new('I love this [animal]!').reify genre).to eq 'I love this {animal ??}!'
  end

  it 'does not inflect placeholders' do
    genre = Genre.new ['/tmp/i-do-not-exist']
    expect(Phrase.new('I adore [animal.plural]!').reify genre).to eq 'I adore {animal ??}!'
  end
end
