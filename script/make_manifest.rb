require 'trollop'
require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'
require_relative './manifestation.rb'

opts = Trollop::options do
  opt :debug, "Display errors and logging", short: '-d'
  opt :genre, "Specify a genre, e.g. '-g scifi'", type: :string, short: '-g', default: 'default'
  opt :phrase, "Specify a phrase or list, e.g. 'The [animal] sat on the [article]' or '[weapon]'", type: :string, short: '-p', default: '[root]'
end

begin
  text = Manifestation.new(opts).text
  puts text
rescue => e
  raise e if opts[:debug]
  `rm #{opts[:genre]}.list 2>&1` unless opts[:debug]
end