class Genre
  GAP_BETWEEN_PALETTES   = /\n(?=\|)/

  def self.from_directories paths
    new palettes_from paths
  end

  def self.palettes_from paths
    paths.flat_map do |path|
      Dir[File.join(path, '**', '*.pal')].flat_map do |filename|
        File.read(filename)
          .split(GAP_BETWEEN_PALETTES)
          .map do |textual_palette|
            Palette.new(textual_palette, filename)
          end
      end
    end
  end

  def initialize palette_list
    self.palettes = Hash[palette_list.map { |p| [p.name, p] }]
  end

  def palette_named name
    palettes[name] || NullPalette.new(name)
  end

  private

  attr_accessor :palettes
end
