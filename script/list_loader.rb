class ListLoader
  def initialize genre = 'default'
    @genre = genre
  end
  
  def load genre=@genre
    dir_of_this_file = File.dirname(__FILE__)
    default_list_dir = File.join(*%W(#{dir_of_this_file} .. lists default ** *))
    Dir[default_list_dir].each { |list_path| create_list_from(list_path) }
    
    if genre != 'default'
      Dir[File.join(*%W(#{dir_of_this_file} .. lists #{genre} ** *))].each { |list_path| create_list_from(list_path) }
    end
  end

  private

  def create_list_from path
    newlines_before_a_pipe = /\n(?=\|)/
    everything_up_to_the_first_newline_if_first_character_is_a_pipe = /^\|(.*?)\n/
    everything_after_the_last_slash = /\/.+$/
    
    lists = File.open(path).read.split(newlines_before_a_pipe)
    lists.each_with_index do |_list, i|
      list_name = _list.match(everything_up_to_the_first_newline_if_first_character_is_a_pipe)[1].to_s
      
      if list_name.empty?
        list_name = path.match(everything_after_the_last_slash).to_s
      else
        _list.gsub!(everything_up_to_the_first_newline_if_first_character_is_a_pipe, '')
      end
      
      phrase_class_name = list_name.underscore.camelize
      begin
        qlass = "Phrase::#{phrase_class_name}".constantize
      rescue NameError
        qlass = Class.new(Phrase)
        Phrase.const_set phrase_class_name, qlass
      end
      
      qlass.list(_list)
    end
  end
end


