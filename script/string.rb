class String
  def is_name?
    self[0] == '|'
  end

  def listerpolate
    # self.gsub('[', '#{').gsub(']', '}')
    
    while self.match(/\[\w+\]/) do
      slug = self.match(/\[\w+\]/).to_s
      slug = slug.gsub('[', '').gsub(']', '')
      self.gsub(slug, Kernel.send(slug))
    end

    self
  end
end