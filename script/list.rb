class List
  attr_accessor :name

  def initialize opts={}
    @name = opts.fetch(:name, 'default')
    @members = opts.fetch(:members, [])
    @universe = opts.fetch(:universe)
    @universe.lists[name] = self
  end

  
  def << rough_member
    pieces = rough_member.split('@')

    weight = pieces.length > 1 ? pieces.shift.to_i : 1

    attrs = {body: pieces.pop, list: self, universe: universe}
    attrs.merge!(frequency: pieces.pop) if pieces.any?
    member = Member.new(attrs)

    weight.times { members << member }
  end
  
  def sample
    members.sample
  end

  private 
  attr_accessor :members, :universe
end