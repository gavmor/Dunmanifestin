class ListLoader
  def initialize genre = 'default'
    @genre = genre
  end

  def load
    Dir["./lists/#{@genre}/**/*"].each do |path|
      newlines_before_a_pipe = /\n\|/ #TODO - use lookaround
      everything_up_to_the_first_newline_if_first_character_is_a_pipe = /^\|(.*?)\n/
      everything_after_the_last_slash = /\/.+$/
      
      lists = File.open(path).read.split(newlines_before_a_pipe)
      lists.each_with_index do |_list, i|
        if i > 0
          _list = "|#{_list}"
        end #TODO - this is a hack to avoid using lookaround
        
        list_name = _list.match(everything_up_to_the_first_newline_if_first_character_is_a_pipe)[1].to_s
        
        if list_name.empty?
          list_name = path.match(everything_after_the_last_slash).to_s
        else
          _list.gsub!(everything_up_to_the_first_newline_if_first_character_is_a_pipe, '')
        end

        qlass = Class.new(Phrase) do
          list _list
        end
        
        Kernel.const_set list_name.underscore.camelize, qlass
      end 
    end
  end
end
