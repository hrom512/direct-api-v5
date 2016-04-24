# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'direct/api/v5/version'

Gem::Specification.new do |spec|
  spec.name          = 'direct-api-v5'
  spec.version       = Direct::API::V5::VERSION
  spec.author        = 'Khrebtov Roman'
  spec.email         = 'roman@alltmb.ru'
  spec.summary       = 'Yandex Direct API V5'
  spec.description   = 'Ruby client for Yandex Direct API V5'
  spec.homepage      = 'https://github.com/Hrom512/direct-api-v5'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'

  spec.add_dependency 'faraday'
  spec.add_dependency 'multi_json'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'byebug'
end
