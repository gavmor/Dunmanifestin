class ListLoader
  class << self
    def load genre=@genre
      Dir[DEFAULT_GENRE].each(&method(:expose_palettes))
      load_genre(genre).each(&method(:expose_palettes))
    end

    private
    PALETTE_TITLE       = /^\|(.*?)\n/
    GAP_BETWEEN_LISTS   = /\n(?=\|)/
    DEFAULT_GENRE       = File.join(*%W(#{File.dirname(__FILE__)} .. .. default-genre ** *))

    def load_genre dirname
      Dir[File.join(dirname, '**' '*')]
    end

    def expose_palettes path
      File.open(path).read.split(GAP_BETWEEN_LISTS)
        .each &method(:expose_swatches)
    end

    def expose_swatches body
        list_name = body.match(PALETTE_TITLE)[1].to_s

        if list_name.empty?
          # This seems to support palettes without |explicitTitles,
          #  Taking them from the filename, instead.
          list_name = Pathname.new(path).basename
        else
          # Do not include palette title as a swatch
          # These comments should be tests.
          body.gsub!(PALETTE_TITLE, '')
        end

        # This metaprogramming is mysterious to me.
        qlass = declare_phrase_class list_name
        # Where is 'list' defined?
        qlass.list body
    end

    def declare_phrase_class list_name
      name = list_name.underscore.camelize
      qlass = "Phrase::#{name}".constantize
    rescue NameError
      # This seems to always happen.
      qlass = Class.new(Phrase)
      Phrase.const_set name, qlass
    end
  end
end


