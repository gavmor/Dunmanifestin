# encoding: utf-8

class String
  def split_on_newlines_and_strip
    split(/\s*\n\s*/).reject(&:empty?)
  end
end
