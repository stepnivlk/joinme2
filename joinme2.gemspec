# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'joinme2/version'

Gem::Specification.new do |spec|
  spec.name          = 'joinme2'
  spec.version       = Joinme2::VERSION
  spec.authors       = ['Tomas Koutsky']
  spec.email         = ['tomas@stepnivlk.net']

  spec.summary       = %q{Ruby wrapper for Joinme API.}
  spec.description   = %q{With this gem you can easily manage all your meetings.}
  spec.homepage      = 'https://github.com/stepnivlk/joinme2'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'hashie'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry'
end
