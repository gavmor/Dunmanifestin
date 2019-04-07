require_relative './object'

class Genre
  GAP_BETWEEN_PALETTES   = /\n(?=\|)/

  def initialize paths
    @paths = paths
  end

  def palette_named name
    palettes[name] || NullPalette.new(name)
  end

  private

  def palettes
    @palettes ||= {}.tap do |palettes|
      load_data_into palettes, from: @paths
    end
  end

  def load_data_into palette_hash, from:
    from.each do |path|
      Dir[File.join(path, '**', '*.pal')].each do |filename|
        File.read(filename)
          .split(GAP_BETWEEN_PALETTES)
          .each do |textual_palette|
            palette = Palette.new(textual_palette, filename)
            palette_hash[palette.name] = palette
          end
      end
    end
  end
end
