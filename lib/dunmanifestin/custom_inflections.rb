require 'active_support/inflector'

ActiveSupport::Inflector.inflections do |inflect| 
  inflect.irregular 'human', 'humans' 
end