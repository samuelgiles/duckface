
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duckface/version'

Gem::Specification.new do |spec|
  spec.name          = 'duckface-interfaces'
  spec.version       = Duckface::VERSION
  spec.authors       = ['Bellroy Tech Team']
  spec.email         = ['tech@bellroy.com']

  spec.summary       = 'Duckface'
  spec.description   = 'Duck typing + Interfaces'
  spec.homepage      = 'https://github.com/samuelgiles/duckface'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
end
