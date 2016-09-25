require_relative 'phrase'
require_relative 'string'
require_relative 'palette'

class ListLoader
  DEFAULT_GENRE = File.join(*%W(#{File.dirname(__FILE__)} .. .. default-genre))
  
  class << self
    def load super_genre=""
      [DEFAULT_GENRE, super_genre.split(":")]
        .flatten.compact.each(&method(:load_genre))
    end

    private

    def load_genre dirname
      Dir[File.join(dirname, '**' '*')].each(&Palette.method(:expose))
    end    
  end
end


