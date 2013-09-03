class Generator
  def self.from_file path
    new File.open(path).readlines.map(&:chomp).reject { |line| line.empty? }.unshift('root')
  end

  def initialize lines 
    lines.inject do |list, line|
      list = lists[line] || List.new(name: line, world: self) if line.is_name?
      list << line unless line.is_name?
      list
    end
  end

  def lists
    @lists ||= {}
  end

  def generate kind
    list = lists[kind] || lists['|' + kind]
    list.sample
  end
end