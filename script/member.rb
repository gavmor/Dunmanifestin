class Member
  attr_reader :body, :list

  def initialize(opts={})
    @list = opts.fetch(:list)
    @freq = opts.fetch(:frequency, 1)
    @body = opts.fetch(:body)
    @universe = opts.fetch(:universe)
  end

  def to_s
    body.listerpolate(universe).to_s
  end

  private
  
  attr_reader :universe
end