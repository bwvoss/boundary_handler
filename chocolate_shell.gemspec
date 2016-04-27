require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'chocolate_shell'
  s.version     = ChocolateShell::VERSION
  s.summary     = 'Provides a clean boundary for error handling and logging'
  s.description = 'For error handling'
  s.authors     = ['Ben Voss']
  s.email       = 'bwvoss@gmail.com'
  s.files       = ['lib/chocolate_shell.rb']
  s.homepage    = 'http://github.com/bwvoss'
  s.license     = 'MIT'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec', '~>  3.4'
  s.add_development_dependency 'flog'
  s.add_development_dependency 'bundler-audit'
  s.add_development_dependency 'simplecov'
end
