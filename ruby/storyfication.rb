require './member.rb'
require './list.rb'
require './generator.rb'
require './string.rb'


gen = Generator.from_file '../root'
# p List.with_name('|root').members.first.print
p gen.generate('root')