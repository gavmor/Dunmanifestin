class Member
  attr_reader :body, :list

  def initialize(opts={})
    @list = opts.fetch(:list)
    @freq = opts.fetch(:frequency, 1)
    @body = opts.fetch(:body)
  end

  def to_s
    body.listerpolate.unescape
  end
end