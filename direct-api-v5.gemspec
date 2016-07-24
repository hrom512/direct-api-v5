# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'direct/api/v5/version'

Gem::Specification.new do |spec|
  spec.name          = 'direct-api-v5'
  spec.version       = Direct::API::V5::VERSION
  spec.author        = 'Roman Khrebtov'
  spec.email         = 'roman@alltmb.ru'
  spec.summary       = 'Yandex Direct API V5'
  spec.description   = 'Ruby wrapper for Yandex Direct API V5'
  spec.homepage      = 'https://github.com/Hrom512/direct-api-v5'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'

  spec.add_dependency 'hashie', '~> 3.4'
  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'multi_json', '~> 1.12'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'rubocop'
end
