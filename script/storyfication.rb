require_relative './member.rb'
require_relative './list.rb'
require_relative './generator.rb'
require_relative './string.rb'


from_list = 'root'
root_file = 'root.list'

gen = Generator.from_file root_file
text = gen.generate from_list

while text.length > 500
  text = gen.generate from_list
end

puts text
# `echo #{text} | pbcopy $1`
