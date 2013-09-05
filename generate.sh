rm root.list
find ./lists/default/* -exec cat {} > root.list +
ruby script/make_manifest.rb "$@"