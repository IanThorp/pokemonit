# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pokemonit/version'

Gem::Specification.new do |spec|
  spec.name          = "pokemonit"
  spec.version       = Pokemonit::VERSION
  spec.authors       = ["Ian Thorp"]
  spec.email         = ["IanMThorp@gmail.com"]

  spec.summary       = %q{my summary}
  spec.description   = %q{my description}
  spec.homepage      = "http://mysite.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "unirest", "1.1.2"
end
