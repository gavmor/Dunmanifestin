class String
  def is_name?
    self[0] == '|'
  end

  def listerpolate universe
    body = self
    
    while body.match(/\[\w+\]/) do
      slug = body.match(/\[\w+\]/).to_s
      phrase = universe.send(slug.gsub('[', '').gsub(']', ''))
      body = body.sub(slug, phrase)
    end

    body
  end
  
  def split_on_newlines_and_strip
    split(/\s*\n\s*/).reject(&:empty?)
  end
end