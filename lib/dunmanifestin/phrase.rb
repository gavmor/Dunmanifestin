require 'active_support/inflector'
require_relative 'custom_inflections'

class Phrase
  def self.list new_list = nil
    return (@list || []) unless new_list

    if new_list.is_a? String
      new_list = new_list.split_on_newlines_and_strip
    end

    new_list.map! do |line|
      multiplier_regex = /^\d+@/
      multiplier = line.match(multiplier_regex).to_s.to_i
      multiplier = 1 if multiplier < 1
      [line.gsub(multiplier_regex, '')] * multiplier
    end.flatten!.reject! { |i| i.nil? || i.empty? }

    @list = new_list
  end

  def initialize dsl_string = self.class.list.sample
    raise "Try again." unless dsl_string
    compile parse dsl_string
  end

  def compile parsed_dsl
    template = parsed_dsl[:template]

    @variable_classes = []
    @inflection_delegates = {
      :plural => [],
      :possessive => [],
      :article => [],
      :capitalize => [],
    }

    inflections = []

    parsed_dsl[:variables].each_with_index do |variable, i|
      rough_var_class = variable[:rough_variable_class]

      variable[:inflections_to_delegate].each do |inflection|
        @inflection_delegates[inflection.to_sym] << i
      end

      inflections[i] = []

      variable[:inflections_to_apply].each do |inflection|
        inflections[i] << inflection.to_sym
      end

      begin
        @variable_classes << "Phrase::#{rough_var_class.camelize}".constantize
      rescue NameError
        @variable_classes << eval(%Q|Class.new(Phrase) do
          def initialize
            @to_s_proc = -> { "{#{rough_var_class} ??}" }
          end
        end|)
      end
    end

    @to_s_proc = -> {
      self.variables.each_with_index do |variable, i|
        inflections[i].each do |inflection|
          variable.send "#{inflection}!"
        end
      end
      template.zip(self.variables).flatten.map(&:to_s).join('')
    }
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
    @variables ||= @variable_classes.map(&:new)
  end

  def plural?;     !!@plural     end
  def possessive?; !!@possessive end
  def article?;    !!@article    end
  def capitalize?; !!@capitalize end
  def titleize?;   !!@titleize   end

  def plural!
    @plural = true

    @inflection_delegates[:plural].each do |delegate|
      variables[delegate].plural!
    end
    self
  end

  def article!
    @article = true

    @inflection_delegates[:article].each do |delegate|
      variables[delegate].article!
    end
    self
  end

  def possessive!
    @possessive = true

    @inflection_delegates[:possessive].each do |delegate|
      variables[delegate].possessive!
    end
    self
  end

  def capitalize!
    @capitalize = true

    @inflection_delegates[:capitalize].each do |delegate|
      variables[delegate].capitalize!
    end
    self
  end

  def titleize!
    @titleize = true

    @inflection_delegates[:capitalize].each do |delegate|
      variables[delegate].capitalize!
    end
    self
  end

  def to_s
    render_inflections @to_s_proc.call
  end

  def render_inflections string
    if plural?
      string = string.pluralize if @inflection_delegates[:plural].empty?
      if possessive? && @inflection_delegates[:possessive].empty?
        if string =~ /s$/
          string = "#{string}'"
        else
          string = "#{string}'s"
        end
      end
    else
      #singular
      if article? && @inflection_delegates[:article].empty?
        if string =~ /^[aeiou]/i
          string = "an #{string}"
        else
          string = "a #{string}"
        end
      end
      if possessive? && @inflection_delegates[:possessive].empty?
        string = "#{string}'s"
      end
    end

    string = string[0].capitalize + string[1 .. -1] if capitalize?
    string = string.titleize if titleize?

    string
  end
end
