require 'phrase'

class Person < Phrase
  list %Q{
    [nounPhrase] [verbPhrase] [sentenceModifier]
    [nounPhrase] [verbPhrase]
  }
end

class NounPhrase < Phrase
  list %Q(
    [nounPhrase1.article]
    the [nounPhrase1]
    [nounPhrase1.plural]
  )
end

class NounPhrase1 < Phrase
  list %Q{
    [noun#plural]
    [adjectiveList] [noun#plural]
    [adjectiveList] [noun#plural] [prepositionalPhrase]
    [possessivePronoun] [noun#plural]
  }
end

class Noun < Phrase
  list %Q{
    pirate
    cactus
    zombie
    ninja
    donut
    waffle
    monkey
  }
end

class VerbPhrase < Phrase
  list %Q{
    [intransitiveVerb]
    [transitiveVerb] [noun]
  }
end

class IntransitiveVerb < Phrase
  list %Q{
    sits
    runs
    eats
    
  }
end

class Adjective
end

class Description < Phrase
  list %Q{
    pursued by [adjective.article] bear
    with a [noun]
  }
end

50.times { puts Sentence.new }

puts "\n##### possessives #####"
5.times { puts Item.new.possessive! }

puts "\n##### indefinite articles #####"
5.times { puts Item.new.article! }