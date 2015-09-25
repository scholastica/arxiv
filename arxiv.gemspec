# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "arxiv/version"

Gem::Specification.new do |s|
  s.name        = "arxiv"
  s.version     = Arxiv::VERSION
  s.authors     = ["Scholastica"]
  s.email       = ["coryschires@gmail.com"]
  s.homepage    = "https://github.com/scholastica/arxiv"
  s.summary     = "Ruby wrapper accessing the arXiv API"
  s.description = "Easily access arXiv article info – including authors, categories, links, etc."
  s.licenses    = ['MIT']
  s.rubyforge_project = "arxiv"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "happymapper", '~> 0.4', '>= 0.4.1'
  s.add_runtime_dependency "nokogiri",    '~> 1.6', '>= 1.6.6.2'

  s.add_development_dependency "rspec", '~> 3.3', '>= 3.3.0'
  s.add_development_dependency "pry",   '~> 0.10.2'
end
