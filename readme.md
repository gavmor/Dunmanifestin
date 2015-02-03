# Microscope-style, Palette-based Generation of Plausible Phrases
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
3. `dunmanifestin -p 'I had a [animal], once. Its name was [name].'

Try `dunamnifestin --help` for usage:

```
Options:
        --debug, -d:   Display errors and logging
  --interactive, -i:   Use an interactive command prompt
    --count, -n <i>:   Specify how many lines of output to generate at once
         --copy, -c:   Copies manifestation into your clipboard
    --genre, -g <s>:   Specify a genre by filepath, e.g. '-g lists/scifi/'
                       (default: default)
   --phrase, -p <s>:   Specify a phrase or list, e.g. 'The [animal] sat on the
                       [article]' or '[weapon]'
        --chomp, -h:   remove the trailing newline from the output
     --file, -f <s>:   Read a file as the phrase
         --help, -e:   Show this message
```
### ToDo
[x] Load lists from arbitrary path, instead of Gem source directory
[ ] More tests!
[ ] Explicitly namespace genres, palettes and swatches

