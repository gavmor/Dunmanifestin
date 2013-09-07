require 'trollop'
require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'
require_relative './manifestation.rb'

user_demands = Trollop::options do
  opt :debug, "Display errors and logging", short: '-d'
  opt :copy, "Copies manifestation into your clipboard", short: '-c'
  opt :genre, "Specify a genre, e.g. '-g scifi'", type: :string, short: '-g', default: 'default'
  opt :phrase, "Specify a phrase or list, e.g. 'The [animal] sat on the [article]' or '[weapon]'", type: :string, short: '-p', default: '[root]'
end

begin
  text = Manifestation.new(user_demands).text
  puts text
  `echo #{text} | pbcopy $1` if user_demands[:copy]
rescue => e
  raise e if user_demands[:debug]
  `rm #{user_demands[:genre]}.list 2>&1` unless user_demands[:debug]
end