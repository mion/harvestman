# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harvestman/version'

Gem::Specification.new do |gem|
  gem.name          = "harvestman"
  gem.version       = Harvestman::VERSION
  gem.authors       = ["Gabriel Vieira"]
  gem.email         = ["gluisvieira@gmail.com"]
  gem.summary       = %q{Lightweight web crawler}
  gem.homepage      = ""

  # Runtime dependencies
  gem.add_dependency "nokogiri", "~> 1.5.6"

  # Development dependencies
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
