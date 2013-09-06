require 'trollop'
require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'
require_relative './phrase.rb'
require_relative './manifestation.rb'
require_relative './list_loader.rb'

opts = Trollop::options do
  opt :debug, "Display errors and logging", short: '-d'
  opt :copy, "Copies manifestation into your clipboard", short: '-c'
  opt :genre, "Specify a genre, e.g. '-g scifi'", type: :string, short: '-g', default: 'default'
  opt :phrase, "Specify a phrase or list, e.g. 'The [animal] sat on the [article]' or '[weapon]'", type: :string, short: '-p', default: '[root]'
end

begin
  #text = Manifestation.new(opts).text
  root_phrase_class = Class.new(Phrase) do
    list opts[:phrase]
  end
  
  ListLoader.new(opts[:genre]).load

  text = root_phrase_class.new
  
  puts text.inspect
  `echo #{text} | pbcopy $1` if opts[:copy]
rescue => e
  raise e if opts[:debug]
  `rm #{opts[:genre]}.list 2>&1` unless opts[:debug]
end