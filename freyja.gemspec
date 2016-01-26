# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freyja/version'

Gem::Specification.new do |gem|
  gem.name          = 'freyja'
  gem.version       = Freyja::VERSION
  gem.date          = '2016-01-26'
  gem.summary       = "Freyja, Njord`s daughter"
  gem.description   = "Lightweight hash transformer"
  gem.authors       = ["Stanislav Spiridonov"]
  gem.email         = 'stanislav@spiridonov.pro'

  gem.add_dependency 'activesupport'

  gem.files         = `git ls-files lib/`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.homepage      = 'https://github.com/spiridonov/freyja'
end
