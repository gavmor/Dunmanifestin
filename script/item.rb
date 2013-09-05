require 'phrase'

class Item < Phrase
  list [
    "[adjective] [noun#plural#possessive]",
    "[noun#plural#possessive]",
    "[noun#plural#possessive] [description]",
    "really [adjective], [adjective] [noun.plural#possessive]",
  ]
end

class Adjective < Phrase
  list [
    "flowery",
    "bandaged",
    "obtuse",
    "orange",
    "agnostic",
  ]
end

class Noun < Phrase
  list [
    "tube",
    "tank",
    "oak",
    "elf",
  ]
end

class Description < Phrase
  list [
    "with [noun.article]",
    "pursued by [adjective.article] bear",
    "soaked in brine",
  ]
end

puts "\n##### plurals #####"
5.times { puts Item.new.plural! }

puts "\n##### possessives #####"
5.times { puts Item.new.possessive! }

puts "\n##### indefinite articles #####"
5.times { puts Item.new.article! }