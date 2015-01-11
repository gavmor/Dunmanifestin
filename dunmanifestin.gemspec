Gem::Specification.new do |s|
  s.name        = 'dunmanifestin'
  s.version     = '0.0.5'
  s.summary     = 'A verisimilitude generator.'
  s.description = "The point of Dunmanifestin [is] to inject chaos into humans' cliched ideas or, at least, let them be hunter-gatherers instead of farmers of culture. -- B. Christel"
  s.authors     = %w(quavmo benchristel AlexLerman)
  s.email       = 'quavmo@gmail.com'
  s.files       = Dir['lib/**/*'] + Dir['lists/**/*']
  s.executables = ['dunmanifestin']
  s.homepage    = 'http://github.com/quavmo/dunmanifestin'
  s.license     = 'MIT'

  s.add_dependency 'trollop', '~> 2.0'
  s.add_development_dependency 'rspec', '~> 0'
end
