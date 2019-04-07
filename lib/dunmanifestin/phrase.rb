require 'active_support/inflector'
require_relative 'custom_inflections'
require_relative 'array'

class Phrase
  def self.list new_list = nil, multiline_document = false
    return @list unless new_list

    new_list = new_list.split_on_newlines_and_strip if new_list.is_a?(String) unless multiline_document
    new_list = [new_list] if multiline_document

    new_list.map! do |line|
      multiplier_regex = /^\d+@/
      multiplier = line.match(multiplier_regex).to_s.to_i
      multiplier = 1 if multiplier < 1
      [line.gsub(multiplier_regex, '')] * multiplier
    end.flatten!.reject! { |i| i.nil? || i.empty? }

    @list = new_list
  end

  def initialize dsl_string
    raise "Try again." unless dsl_string
    compile parse dsl_string
  end

  def compile parsed_dsl
    @template = parsed_dsl[:template]

    @variable_classes = []
    @inflection_delegates = {
      :plural => [],
      :possessive => [],
      :article => [],
      :capitalize => [],
    }

    @inflections = []

    parsed_dsl[:variables].each_with_index do |variable, i|
      rough_var_class = variable[:rough_variable_class]

      variable[:inflections_to_delegate].each do |inflection|
        @inflection_delegates[inflection.to_sym] << i
      end

      @inflections[i] = []

      variable[:inflections_to_apply].each do |inflection|
        @inflections[i] << inflection.to_sym
      end

      begin
        @variable_classes << "Phrase::#{rough_var_class.camelize}".constantize
      rescue NameError
        @variable_classes << empty_phrase_class(rough_var_class)
      end
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

  def variables
    @variables ||= @variable_classes.map do |c|
      # TODO: had to add this grossness to work around the
      # fact that the Terminator tests are somehow calling
      # this before c.list is set. I blame mocking.
      c.new(c.list ? c.list.constrained_sample : '')
    end
  end

  def plural?;     !!@plural     end
  def possessive?; !!@possessive end
  def article?;    !!@article    end
  def capitalize?; !!@capitalize end
  def titleize?;   !!@titleize   end

  def titleize!
    delegates = @inflection_delegates[:capitalize]
    delegates.each { |delegate| variables[delegate].capitalize! }
  end

  def inflect inflection
    return self unless @inflection_delegates
    self.instance_variable_set("@#{inflection}", true)
    return (titleize! && self) if inflection == :titleize

    delegates = @inflection_delegates[inflection]
    delegates.each { |delegate| variables[delegate].inflect inflection }
    self
  rescue NoMethodError
    puts "==> Failed to inflect: .#{inflection}?"
    puts "==> Valid inflections are: plural, possessive, article, capitalize, titleize"
    self
  end

  def to_s
    variables.each_with_index do |variable, i|
      @inflections[i].each(&variable.method(:inflect))
    end
    render_inflections @template.zip(variables).flatten.map(&:to_s).join('')
  end

  def render_inflections string
    # Good, now turn this into a stateless function.
    string = string.pluralize if plural? && @inflection_delegates[:plural].empty?
    string = (string =~ /s$/) ? "#{string}'" : "#{string}'s" if plural? && possessive? && @inflection_delegates[:possessive].empty?
    string = "#{string}'s" if !plural? && possessive? && @inflection_delegates[:possessive].empty?
    string = (string =~ /^[aeiou]/i) ? "an #{string}" : "a #{string}" if !plural? && article? && @inflection_delegates[:article].empty?
    string = string[0].capitalize + string[1 .. -1] if capitalize?
    string = string.titleize if titleize?

    string
  end

  private

  def empty_phrase_class name
    class_definition = <<-RUBY
      Class.new(Phrase) do
        def to_s
          "{#{name} ??}"
        end
      end
    RUBY

    eval(class_definition)
  end

end
