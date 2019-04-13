require_relative './phrase'
require_relative './churn'

class NullPalette
  def initialize name
    @name = name
  end

  def name
    @name
  end

  def sample _, _, _
    "{#{@name} ??}"
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
    lines.first.sub(/\|(\w+).*$/, '\1')
  end

  def sample genre, inflections = [], constraints = []
    if inflections.any?
      # don't use the churn if there are inflections, since
      # they'll be cached...
      phrases.sample.reify(genre, inflections)
    else
      if constraints.include? :recur
        churn.sample {
          phrases.sample.reify(genre)
        }
      else
        churn.generate {
          phrases.sample.reify(genre)
        }
      end
    end
  end

  private

  def file_basename
    File.basename(@filename, '.pal')
  end

  def churn
    @churn ||= Churn.new novelty: novelty do
      phrases.sample.reify(genre, [])
    end
  end

  def novelty
    lines.first.sub(/^.*\*(\d+).*$/, '\1').to_i
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
