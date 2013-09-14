require 'trollop'
require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'
require_relative './phrase.rb'
require_relative './manifestation.rb'
require_relative './list_loader.rb'

user_demands = Trollop::options do
  opt :debug, "Display errors and logging", short: '-d'
  opt :interactive, "Use an interactive command prompt", short: '-i'
  opt :count, "Specify how many lines of output to generate at once", type: :integer, short: '-n'
  opt :copy, "Copies manifestation into your clipboard", short: '-c'
  opt :genre, "Specify a genre, e.g. '-g scifi'", type: :string, short: '-g', default: 'default'
  opt :phrase, "Specify a phrase or list, e.g. 'The [animal] sat on the [article]' or '[weapon]'", type: :string, short: '-p', default: '[root]'
end

def get_from_prompt
  print "dunmanifestin > "
  gets.chomp
end

begin
  root_phrase_class = Class.new(Phrase) { list user_demands[:phrase] } 
  ListLoader.new(user_demands[:genre]).load

  if user_demands[:interactive]
    print "---------------------------------------------------------------------\n"+
          "Type 'quit' to exit the prompt. Press return to generate more output.\n"+
          "---------------------------------------------------------------------\n\n"
  end
  
  fulltext = ""
  
  while true
    (user_demands[:count] || 1).times do
      text = root_phrase_class.new.inspect
      fulltext += "\n#{text}"
      puts text
    end

    `echo #{fulltext.inspect} | pbcopy $1` if user_demands[:copy]
    
    break if !user_demands[:interactive] || get_from_prompt == 'quit'
  end
  
rescue => e
  raise e if user_demands[:debug]
ensure
  `rm #{user_demands[:genre]}.list 2>&1` unless user_demands[:debug]
end