require_relative 'genre'
require_relative 'phrase'
require_relative 'palette'

class Terminator
  def initialize(shell: Shell)
    @shell = shell
  end

  def address demands
    self.demands = demands

    Array.coarse_seed = coarse_seed
    Array.fine_seed   = fine_seed
    Array.diversity   = 2
    Array.recurrences = 20

    print interactive_banner if interactive

    construction_loop
  end

  private

  attr_accessor :shell, :demands

  def construction_loop
    fulltext = ""
    while true
      volume.times do
        text = Phrase.new(phrasing).reify genre
        fulltext += "\n#{text}"
        text += "\n" unless chomp
        shell.puts text
      end

      `echo #{fulltext.inspect} | pbcopy $1` if copy

      break unless interactive
      break if get_from_prompt == 'quit'
    end
  end

  def genre
    @genre ||= Genre.from_directories genre_directories
  end

  def genre_directories
    ([default_genre_path] + demanded_genres).reject(&:empty?)
  end

  def phrasing
    demanded_phrase || demanded_file_contents || '[root]'
  end

  def get_from_prompt
    shell.print "dunmanifestin > "
    shell.gets.chomp
  end

  def interactive_banner
    message = "Type 'quit' to exit the prompt. Press return to generate more output."
    bar = "-"*message.length
    [bar, message, bar].join "\n"
  end

  def chomp
    demands[:chomp]
  end

  def copy
    demands[:copy]
  end

  def volume
    demands[:count] || 1
  end

  def interactive
    demands[:interactive]
  end

  def demanded_genres
    demands[:genre] ? demands[:genre].split(':') : []
  end

  def demanded_file
    demands[:file]
  end

  def demanded_file_contents
    demanded_file && File.read(demanded_file)
  end

  def demanded_phrase
    demands[:phrase]
  end

  def coarse_seed
    demands[:coarse_seed]
  end

  def fine_seed
    demands[:fine_seed]
  end

  def default_genre_path
    File.join(*%W(#{File.dirname(__FILE__)} .. .. default-genre))
  end

  module Shell
    class << self
      def method_missing method, *args
        send method, *args
      end
    end
  end
end
