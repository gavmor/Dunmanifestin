class ListLoader
  class << self
    def load genre=@genre
      Dir[default_list_dir].each(&method(:create_list_from))

      genre_files = Dir[File.join(genre, '**' '*')]
      genre_files.each(&method(:create_list_from)) unless genre == 'default'
    end

    private
    LIST_HEADER = /^\|(.*?)\n/
    GAP_BETWEEN_LISTS = /\n(?=\|)/

    def default_list_dir
      File.join(*%W(#{File.dirname(__FILE__)} .. .. lists default ** *))
    end

    def create_list_from path
      lists = File.open(path).read.split(GAP_BETWEEN_LISTS)
      lists.each_with_index do |_list, i|
        list_name = _list.match(LIST_HEADER)[1].to_s

        if list_name.empty?
          list_name = Pathname.new(path).basename
        else
          _list.gsub!(LIST_HEADER, '')
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
end


