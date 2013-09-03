class Generator
  def self.from_file path
    new File.open(path).readlines.map(&:chomp).reject { |line| line.empty? }.unshift('root')
  end

  def initialize lines 
    lines.inject do |list, line|
      list = lists[line] || List.new(name: line, universe: self) if line.is_name?
      list << line unless line.is_name?
      list
    end
  end

  def lists
    @lists ||= {}
  end

  def generate kind
    kind = kind.to_s
    list = lists[kind] || lists['|' + kind]
    raise NoSuchList.new(kind) unless list
    list.sample.to_s
  end

  def method_missing slug
    generate slug
  end
end

class NoSuchList < StandardError
  def initialize(kind)
    p "No such list: #{kind}"
  end
end