# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'direct/api/v5/version'

Gem::Specification.new do |spec|
  spec.name          = 'direct-api-v5'
  spec.version       = Direct::API::V5::VERSION
  spec.authors       = ['Khrebtov Roman']
  spec.email         = ['roman@alltmb.ru']
  spec.summary       = 'Client for Yandex Direct API V5'
  spec.description   = 'Client for Yandex Direct API V5'
  spec.homepage      = 'https://github.com/Hrom512/direct-api-v5'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
