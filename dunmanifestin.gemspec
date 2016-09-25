Gem::Specification.new do |s|
  s.name        = 'dunmanifestin'
  s.version     = '0.1.0'

  s.summary     = 'A verisimilitude generator.'
  s.description = "The point of Dunmanifestin [is] to inject chaos into humans' cliched ideas or, at least, let them be hunter-gatherers instead of farmers of culture. -- B. Christel"
  s.authors     = %w(quavmo benchristel AlexLerman)
  s.email       = 'quavmo@gmail.com'
  s.files       = Dir['lib/**/*'] + Dir['default-genre/**/*']
  s.executables = ['dunmanifestin']
  s.homepage    = 'http://github.com/quavmo/dunmanifestin'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.1.2'

  s.add_runtime_dependency 'trollop', '>= 2.1.2'
  s.add_runtime_dependency 'activesupport', '>= 4.0.0'

  s.add_development_dependency 'rspec', '>= 3.0.0'
  s.add_development_dependency 'rake'
end
