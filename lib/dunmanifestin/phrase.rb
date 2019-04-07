require 'active_support/inflector'
require_relative 'custom_inflections'
require_relative 'array'

class NullPhrase
  def initialize dsl_string
    @dsl_string = dsl_string
  end

  def reify _, _
    @dsl_string
  end

  def inflect _
  end
end

class Phrase
  def initialize dsl_string
    raise "Try again." unless dsl_string
    compile parse dsl_string
  end

  def reify genre, requested_inflections = []
    vals = subphrases(genre).each_with_index.map { |subphrase, i|
      subphrase_inflections = @inflections[i] | (requested_inflections & @delegated_inflections[i])
      subphrase.reify genre, subphrase_inflections
    }
    render_inflections @template.zip(vals).flatten.join(''), requested_inflections
  end

  private

  def compile parsed_dsl
    @template = parsed_dsl[:template]

    @variable_palette_names = []
    @inflection_delegates = {
      :plural => [],
      :possessive => [],
      :article => [],
      :capitalize => [],
    }

    @inflections = []
    @delegated_inflections = []

    parsed_dsl[:variables].each_with_index do |variable, i|
      rough_var_class = variable[:rough_variable_class]

      @delegated_inflections[i] = variable[:inflections_to_delegate].map(&:to_sym)
      variable[:inflections_to_delegate].each do |inflection|
        @inflection_delegates[inflection.to_sym] << i
      end

      @inflections[i] = []

      variable[:inflections_to_apply].each do |inflection|
        @inflections[i] << inflection.to_sym
      end

      @variable_palette_names << rough_var_class
    end
  end

  def parse dsl_string = @dsl_string
    # A dsl string like "[adjective] [noun.possessive#plural]" will be parsed into
    # { :variables =>
    #   [ { :rough_variable_class => 'adjective',
    #       :inflections_to_delegate => [],
    #       :inflections_to_apply => []
    #     },
    #     { :rough_variable_class => 'noun',
    #       :inflections_to_delegate => [:plural],
    #       :inflections_to_apply => [:possessive]
    #     }
    #   ],
    #   :template => ["", " "]
    # }
    #
    tokens = dsl_string.split(/[\[\]]/)
    template = []; variables = [];

    tokens.each_with_index do |token, i|
      if i % 2 == 0
        template << token
      else
        variables << token
      end
    end

    hash = {:variables => [], :template => template}

    variables.each_with_index do |variable, i|
      components = variable.split(/\b/)
      rough_var_class = components.shift
      inflections_to_delegate = []
      inflections_to_apply = []

      components.each_with_index do |v, k|
        inflections_to_delegate << v if components[k-1] == '#'
        inflections_to_apply << v if components[k-1] == '.'
      end

      hash[:variables] << {
        :rough_variable_class => rough_var_class,
        :inflections_to_delegate => inflections_to_delegate,
        :inflections_to_apply => inflections_to_apply,
      }
    end

    hash
  end

  def subphrases genre
    @subphrases ||= @variable_palette_names.map do |name|
      genre.palette_named(name).sample
    end
  end

  def render_inflections string, inflections
    plural     = inflections.include? :plural
    article    = inflections.include? :article
    possessive = inflections.include? :possessive
    capitalize = inflections.include? :capitalize
    titleize   = inflections.include? :titleize

    # Good, now turn this into a stateless function.
    string = string.pluralize if plural && @inflection_delegates[:plural].empty?
    string = (string =~ /s$/) ? "#{string}'" : "#{string}'s" if plural && possessive && @inflection_delegates[:possessive].empty?
    string = "#{string}'s" if !plural && possessive && @inflection_delegates[:possessive].empty?
    string = (string =~ /^[aeiou]/i) ? "an #{string}" : "a #{string}" if !plural && article && @inflection_delegates[:article].empty?
    string = string[0].capitalize + string[1 .. -1] if capitalize
    string = string.titleize if titleize

    string
  end

end
