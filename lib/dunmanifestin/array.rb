class Array
  def even_elements
    select.each_with_index { |_, i| i.even? }
  end

  def odd_elements
    select.each_with_index { |_, i| i.odd? }
  end
end
