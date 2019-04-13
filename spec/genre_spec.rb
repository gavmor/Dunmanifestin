require_relative '../lib/dunmanifestin/genre'

describe Genre do
  it 'loads palettes from a specified directory' do
    expect(Dir).to receive(:[]).with('my-genre/**/*.pal').and_return([
      'dummy-file-1',
      'dummy-file-2'
    ])

    expect(File).to receive(:read).with('dummy-file-1').and_return('|foo')
    expect(File).to receive(:read).with('dummy-file-2').and_return('|bar')

    genre = Genre.from_directories(['my-genre'])
    expect(genre.palette_named 'foo').to be_a Palette
    expect(genre.palette_named 'bar').to be_a Palette
  end

  it 'returns a NullPalette when the requested palette does not exist'  do
    expect(Dir).to receive(:[]).with('my-genre/**/*.pal').and_return([
      'dummy-file-1'
    ])
    expect(File).to receive(:read).with('dummy-file-1').and_return('|foo')

    genre = Genre.from_directories(['my-genre'])
    expect(genre.palette_named 'baz').to be_a NullPalette
  end

  it 'has no palettes when there are no files in the genre' do
    expect(Dir).to receive(:[]).with('my-genre/**/*.pal').and_return([])
    expect(File).not_to receive(:read)

    genre = Genre.from_directories(['my-genre'])
    expect(genre.palette_named 'foo').to be_a NullPalette
  end
end
