`The key elements in human thinking are not numbers but labels of fuzzy sets. -- L. Zadeh`

# List-Based Generation of Plausible Phrases

## Try It!

To generate a phrase from the root -- currently an NPC or location description:
`$ ./generate.sh`


## What's Going On?

Immeasurably inspired by [RandListGen](http://www.path-o-logic.com/misc/RandListGen_sample.html).


## Todo

* Fit: ./generate.sh should take listname arguments, or [pattern] phrases.
* Fit: Respect frequency markers, e.g. 3@elf
* Fit: Take list name from file name so we don't have to keep them in sync manually
* Fit: Put newlines in between concatenated lists in root.list


