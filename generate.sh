rm root.list
find ./lists/default/* -exec cat {} > root.list +
ruby script/storyfication.rb