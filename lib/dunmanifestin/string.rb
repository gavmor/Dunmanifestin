# encoding: utf-8

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
  
  alias :original_capitalize :capitalize
  
  def capitalize
    case_mapping = {
      "ä" => "Ä",
      "ö" => "Ö",
    }
    
    s = original_capitalize
    case_mapping.each_pair do |lower, upper|
      s.gsub!(%r{^#{lower}}, upper)
    end
    s
  end
  
  def split_on_newlines_and_strip
    split(/\s*\n\s*/).reject(&:empty?)
  end
end