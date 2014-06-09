# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mozenda/version'

Gem::Specification.new do |spec|
  spec.name = "mozenda"
  spec.version = Mozenda::VERSION
  spec.authors = ["Piotr Woloszun"]
  spec.email = ["piotr.woloszun@gmail.com"]
  spec.description = %q{Mozenda API gem}
  spec.summary = %q{Mozenda API gem}
  spec.homepage = "https://github.com/pwoloszun/mozenda"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  {
    "bundler" => "~> 1.3",
    'activesupport' => '~> 4.1.1',
    "faraday" => "~> 0.9.0",
    "nori" => "~> 2.3.0"
  }.each_pair do |name, version|
    spec.add_development_dependency(name, version)
  end

  spec.add_development_dependency "rake"
end
