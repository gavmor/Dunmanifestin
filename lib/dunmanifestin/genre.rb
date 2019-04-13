class Genre
  GAP_BETWEEN_PALETTES   = /\n(?=\|)/

  def self.from_directories paths
    new palettes_from paths
  end

  def self.palettes_from paths
    palette_hash = {}
    paths.each do |path|
      Dir[File.join(path, '**', '*.pal')].each do |filename|
        File.read(filename)
          .split(GAP_BETWEEN_PALETTES)
          .each do |textual_palette|
            palette = Palette.new(textual_palette, filename)
            palette_hash[palette.name] = palette
          end
      end
    end
    palette_hash
  end

  def initialize palettes
    self.palettes = palettes
  end

  def palette_named name
    palettes[name] || NullPalette.new(name)
  end

  private

  attr_accessor :palettes
end
