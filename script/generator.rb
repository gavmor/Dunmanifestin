class Generator
  def self.from_file path
    new File.open(path).readlines.map(&:chomp).reject { |line| line.empty? }.unshift('root')
  end

  def initialize lines 
    lines.inject do |list, line|
       create_or_append_list(list, line)
    end
  end

  def lists
    @lists ||= {}
  end

  def generate kind
    kind = kind.to_s
    list = lists[kind] || lists['|' + kind]
    return "{#{kind}?}" unless list
    list.sample.to_s
  end

  def manifest phrase
    phrase.listerpolate(self)
  end

  def method_missing slug
    generate slug
  end

  private 

  def create_or_append_list list, line
    if line.is_name?
      list = List.new(name: line, universe: self)
    else
      list << line
    end

    list
  end
end

class NoSuchList < StandardError
end