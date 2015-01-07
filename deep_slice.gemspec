# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deep_slice/version'

Gem::Specification.new do |spec|
  spec.name          = 'deep_slice'
  spec.version       = DeepSlice::VERSION
  spec.authors       = ['John Iacona']
  spec.email         = ['john.iacona@worldone.com']
  spec.summary       = %q{Slice deeply}
  spec.homepage      = 'http://sermo.com'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', ' ~> 10.3'
  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
