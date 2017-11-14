# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retsly/version'

Gem::Specification.new do |spec|
  spec.name          = 'retsly'
  spec.version       = Retsly::VERSION
  spec.authors       = ['Loft47']
  spec.email         = ['support@loft47.com']

  spec.summary       = %(Retsly Library.)
  spec.description   = %(Ruby Library for Retsly API.)
  spec.homepage      = 'http://github.com/Loft47/loft'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|retsly-0.1.0.gem)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'awrence'
  spec.add_runtime_dependency 'model_attribute'
  spec.add_runtime_dependency 'rash'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
end
