require_relative 'phrase'
require_relative 'list_loader'
require_relative 'string'

class Terminator
  def initialize(list_loader: ListLoader, shell: Shell)
    @list_loader = list_loader
    @shell = shell
  end

  def address demands
    phrase_string = phrasing(demands[:phrase], demands[:file])
    root_phrase_class = Class.new(Phrase) { list phrase_string, !!demands[:file] }
    list_loader.load demands[:genre]
    print interactive_banner if demands[:interactive]

    construction_loop(
      root_phrase_class,
      (demands[:count] || 1),
      demands[:chomp],
      demands[:copy],
      demands[:interactive]
    )
  end

  private
  DEFAULT_ROOT_PHRASEAGE = '[root]'
  attr_accessor :list_loader, :shell

  def construction_loop root_phrase_class, volume, chomp, copy, interact
    fulltext = ""
    while true
      volume.times do
        text = root_phrase_class.new.to_s
        fulltext += "\n#{text}"
        text += "\n" unless chomp
        shell.puts text
      end

      `echo #{fulltext.inspect} | pbcopy $1` if copy

      break unless interact
      break if get_from_prompt == 'quit'
    end
  end

  def phrasing given, file
    given || (!!file && File.read(file)) || DEFAULT_ROOT_PHRASEAGE
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

  module Shell
    class << self
      def method_missing method, *args
        send method, *args
      end
    end
  end
end
