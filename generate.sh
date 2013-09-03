rm root.list
find ./lists -exec cat {} > root.list +
ruby script/storyfication.rb