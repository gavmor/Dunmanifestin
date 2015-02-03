#!/bin/sh
gem uninstall dunmanifestin
gem build dunmanifestin.gemspec
LATEST_GEM_BUILD=`exec ls ./*gem | sed 's/\([0-9]\+\).*/\1/g' | sort -n | tail -1`
gem install $LATEST_GEM_BUILD
