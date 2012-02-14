# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "arxiv/version"

Gem::Specification.new do |s|
  s.name        = "arxiv"
  s.version     = Arxiv::VERSION
  s.authors     = ["Cory Schires", "Brian Cody", "Robert Walsh"]
  s.email       = ["coryschires@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby wrapper accessing the arXiv API}
  s.description = %q{Makes interacting with arXiv data really easy.}

  s.rubyforge_project = "arxiv"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "happymapper"
  s.add_runtime_dependency "nokogiri"

  s.add_development_dependency "rspec"

end
