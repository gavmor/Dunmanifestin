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
  COMMENT             = %r{//.*$}
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
    @phrases ||= begin
      lines[valid_phrase_range]
        .map { |line| line.sub(COMMENT, '') }
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

  def valid_phrase_range
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
end
