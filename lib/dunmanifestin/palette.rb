require_relative './phrase'

class NullPalette
  def initialize name
    @name = name
  end

  def name
    @name
  end

  def sample
    NullPhrase.new "{#{@name} ??}"
  end
end

class Palette
    GAP_BETWEEN_LISTS   = /\n(?=\|)/
    PALETTE_TITLE       = /^\|(.*?)\n/
    COMMENT             = /\/\/(.*?)\n/
    REPETITION_PREFIX   = /^\d+@/

  def initialize raw_text, filename
    @raw_text = raw_text
    @filename = filename
  end

  def name
    return file_basename if not titled?
    lines.first[1..-1]
  end

  def sample
    phrases.constrained_sample
  end

  private

  def file_basename
    File.basename(@filename, '.pal')
  end

  def phrases
    @swatches ||= begin
      comment = %r{//.*$}
      lines[valid_swatch_range]
        .map { |line| line.sub(comment, '') }
        .map(&:strip)
        .reject(&:empty?)
        .flat_map { |line|
          if line =~ REPETITION_PREFIX
            [line.sub(REPETITION_PREFIX, '')] * line.to_i
          else
            [line]
          end
        }
        .map(&Phrase.method(:new))
    end
  end

  def valid_swatch_range
    titled? ? 1..-1 : 0..-1
  end

  def lines
    @lines ||= text.split("\n")
  end

  def text
    @text ||= @raw_text.strip
  end

  def titled?
    lines[0][0] == '|'
  end

  class << self
    def expose path
      File.open(path).read
        .split(GAP_BETWEEN_LISTS)
        .each &method(:expose_swatches)
    end

    def expose_swatches body
      body.gsub!(COMMENT, '')
      list_name = body.match(PALETTE_TITLE)[1].to_s

      if list_name.empty?
        # This seems to support palettes without |explicitTitles,
        #  Taking them from the filename, instead.
        list_name = Pathname.new(path).basename
      else
        # Do not include palette title as a swatch
        # These comments should be tests.
        body.gsub!(PALETTE_TITLE, '')
      end

      # This metaprogramming is mysterious to me.
      qlass = declare_phrase_class list_name
      # Where is 'list' defined?
      qlass.list body
    rescue NoMethodError
    end

    def declare_phrase_class list_name
      name = list_name.underscore.camelize
      qlass = "Phrase::#{name}".constantize
    rescue NameError
      # This seems to always happen.
      qlass = Class.new(Phrase)
      Phrase.const_set name, qlass
    end
  end
end
