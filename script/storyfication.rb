require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'


gen = Generator.from_file 'root'
# p List.with_name('|root').members.first.print
p gen.generate('root')