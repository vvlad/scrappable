# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrappable/version'

Gem::Specification.new do |gem|
  gem.name          = "scrappable"
  gem.version       = Scrappable::VERSION
  gem.authors       = ["Vlad Verestiuc"]
  gem.email         = ["vlad.verestiuc@me.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "guard-bundler"
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'terminal-notifier-guard'
  gem.add_dependency "unindent"

  gem.add_dependency "activesupport"
  gem.add_dependency "httparty"
  gem.add_dependency "nokogiri"
end
