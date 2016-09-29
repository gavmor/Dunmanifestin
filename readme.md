# Palette-based Madlib Engine

[![Join the chat at https://gitter.im/quavmo/Dunmanifestin](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/quavmo/Dunmanifestin?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
![Rspec CI on Travis](https://travis-ci.org/quavmo/Dunmanifestin.svg)
[![Code Climate](https://codeclimate.com/repos/54d045cbe30ba00ad8001409/badges/dd5e09d13651ecf061b9/gpa.svg)](https://codeclimate.com/repos/54d045cbe30ba00ad8001409/feed)
[![Test Coverage](https://codeclimate.com/repos/54d045cbe30ba00ad8001409/badges/dd5e09d13651ecf061b9/coverage.svg)](https://codeclimate.com/repos/54d045cbe30ba00ad8001409/feed)

*The key elements in human thinking are not numbers but labels of fuzzy sets. — L. Zadeh*

*The point of Dunmanifestin [is] to inject chaos into humans' cliched ideas or, at least, let them be hunter-gatherers instead of farmers of culture. — B. Christel*

*Eroton, a glass blowery built on a mountain in Rake. Some say it contains priceless pipes made of pearl. — Dunmanifestin*

Immeasurably inspired by [RandListGen](http://www.path-o-logic.com/misc/RandListGen_sample.html).

## Try It!

1. `gem install dunmanifestin`
2. `dunmanifestin`
3. `dunmanifestin -p 'I had a [animal], once. Its name was [name].'`

Try `dunamnifestin --help` for usage:

```
Options:
  -d, --debug          Display errors and logging
  -i, --interactive    Use an interactive command prompt
  -n, --count=<i>      Specify how many lines of output to generate at once
  -c, --copy           Copies manifestation into your clipboard
  -g, --genre=<s>      Specify a genre or two by filepath, e.g. '-g genres/scifi/', '-g ./genres/poetry:./genres/romantics'
  -p, --phrase=<s>     Specify a phrase or list, e.g. 'The [animal] sat on the [article]' or '[weapon]'
  -o, --chomp          remove the trailing newline from the output
  -f, --file=<s>       Read a file as the phrase
  -h, --help           Show this message
```
