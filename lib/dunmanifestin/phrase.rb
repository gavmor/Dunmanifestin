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
end

class Phrase
  def initialize dsl_string
    raise "Try again." unless dsl_string
    @dsl_string = dsl_string
  end

  def reify genre, requested_inflections = []
    vals = variables.map { |variable|
      variable.reify genre, requested_inflections
    }
    render_inflections constant_segments.zip(vals).flatten.join(''), requested_inflections
  end

  private

  def variables
    parsed_dsl[:variables]
  end

  def constant_segments
    parsed_dsl[:constant_segments]
  end

  def parsed_dsl
    @parsed_dsl ||= begin
      tokens = @dsl_string.split(/[\[\]]/)
      constant_segments = tokens.even_elements
      variables         = tokens.odd_elements

      {
        :variables => variables.map(&Variable.method(:new)),
        :constant_segments => constant_segments
      }
    end
  end

  def render_inflections string, inflections
    plural     = inflections.include? :plural
    article    = inflections.include? :article
    possessive = inflections.include? :possessive
    capitalize = inflections.include? :capitalize
    titleize   = inflections.include? :titleize

    # Good, now turn this into a stateless function.
    string = string.pluralize if plural && variables.none?(&:delegated_plural?)
    string = (string =~ /s$/) ? "#{string}'" : "#{string}'s" if plural && possessive && variables.none?(&:delegated_plural?)
    string = "#{string}'s" if !plural && possessive && variables.none?(&:delegated_possessive?)
    string = (string =~ /^[aeiou]/i) ? "an #{string}" : "a #{string}" if !plural && article && variables.none?(&:delegated_article?)
    string = string[0].capitalize + string[1 .. -1] if capitalize
    string = string.titleize if titleize

    string
  end
end

class Variable
  def initialize dsl_string
    components = dsl_string.split(/\b/)
    self.palette_name = components.shift

    self.inflections_delegated_to_me = []
    self.demanded_inflections        = []

    components.each_with_index do |v, k|
      inflections_delegated_to_me << v.to_sym if components[k-1] == '#'
      demanded_inflections << v.to_sym if components[k-1] == '.'
    end
  end

  def reify genre, inflections_of_parent_phrase
    inherited_inflections = inflections_of_parent_phrase & inflections_delegated_to_me
    inflections = demanded_inflections | inherited_inflections
    genre.palette_named(palette_name).sample genre, inflections
  end

  def delegated_plural?
    inflections_delegated_to_me.include? :plural
  end

  def delegated_article?
    inflections_delegated_to_me.include? :article
  end

  def delegated_possessive?
    inflections_delegated_to_me.include? :possessive
  end

  private

  attr_accessor :demanded_inflections, :palette_name, :inflections_delegated_to_me
end
