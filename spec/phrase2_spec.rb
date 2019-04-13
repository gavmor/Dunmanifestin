require_relative '../lib/dunmanifestin/genre'
require_relative '../lib/dunmanifestin/palette'
require_relative '../lib/dunmanifestin/phrase'

describe Phrase do
  let(:frog_prince) do
    genre = double :frog_prince_genre

    allow(genre).to receive(:palette_named).with('animal').and_return(
      double :animal_palette,
        sample: Phrase.new('frog'))

    allow(genre).to receive(:palette_named).with('vestment').and_return(
      double :vestment_palette,
        sample: Phrase.new('suit'))

    allow(genre).to receive(:palette_named).with('classyAnimal').and_return(
      double :classy_animal_palette,
        sample: Phrase.new('[animal#article#plural] wearing [vestment.article#plural]'))

    genre
  end

  let(:dickens) do
    genre = double :dickens_genre

    allow(genre).to receive(:palette_named).with('book').and_return(
      double :book_palette,
        sample: Phrase.new('a tale of two cities'))

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
    expect(Phrase.new('the [classyAnimal]').reify frog_prince).to eq 'the frog wearing a suit'
  end

  it 'renders a placeholder when a variable references a nonexistent palette' do
    genre = Genre.from_directories ['/tmp/i-do-not-exist']
    expect(Phrase.new('I love this [animal]!').reify genre).to eq 'I love this {animal ??}!'
  end

  it 'does not inflect placeholders' do
    genre = Genre.from_directories ['/tmp/i-do-not-exist']
    expect(Phrase.new('I adore [animal.plural]!').reify genre).to eq 'I adore {animal ??}!'
  end
end
