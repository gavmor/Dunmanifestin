require_relative 'phrase'
require_relative 'list_loader'
require_relative 'string'

class Terminator
  def initialize(list_loader: ListLoader, shell: Shell)
    @list_loader = list_loader
    @shell = shell
  end

  def address demands
    self.demands = demands

    Array.coarse_seed = coarse_seed
    Array.fine_seed   = fine_seed
    Array.diversity   = 2
    Array.recurrences = 20

    list_loader.load demanded_genre
    print interactive_banner if interactive

    construction_loop
  end

  private

  attr_accessor :list_loader, :shell, :demands

  def construction_loop
    fulltext = ""
    while true
      volume.times do
        text = root_phrase_class.new(phrasing).to_s
        fulltext += "\n#{text}"
        text += "\n" unless chomp
        shell.puts text
      end

      `echo #{fulltext.inspect} | pbcopy $1` if copy

      break unless interactive
      break if get_from_prompt == 'quit'
    end
  end

  def root_phrase_class
    @root_phrase_class ||= Class.new(Phrase).tap do |c|
      c.list phrasing, demanded_file
    end
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

  def demanded_genre
    demands[:genre]
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

  module Shell
    class << self
      def method_missing method, *args
        send method, *args
      end
    end
  end
end
