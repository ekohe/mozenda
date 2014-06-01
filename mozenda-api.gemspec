# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mozenda/version'

Gem::Specification.new do |spec|
  spec.name          = "mozenda-api"
  spec.version       = Mozenda::Api::VERSION
  spec.authors       = ["Piotr Woloszun"]
  spec.email         = ["piotr.woloszun@gmail.com"]
  spec.description   = %q{Mozenda API gem}
  spec.summary       = %q{Mozenda API gem}
  spec.homepage      = "https://github.com/pwoloszun/mozenda-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
