class List
  attr_accessor :name

  def initialize opts={}
    @name = opts.fetch(:name, 'default')
    @members = opts.fetch(:members, [])
    @generator = opts.fetch(:world)
    @generator.lists[name] = self
  end

  
  def << rough_member
    pieces = rough_member.split('@')
    
    attrs = {body: pieces.pop, list: self}
    attrs.merge!(frequency: pieces.pop) if pieces.any?
    member = Member.new(attrs)

    members << member
  end
  
  def sample
    p name
    p members
    members.sample
  end

  private 
  attr_accessor :members
end