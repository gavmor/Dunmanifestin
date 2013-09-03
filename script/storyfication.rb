require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'


gen = Generator.from_file 'root.list'
p gen.generate('root')