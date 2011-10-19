# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "muplin/version"

Gem::Specification.new do |s|
  s.name        = "muplin"
  s.version     = Muplin::VERSION
  s.authors     = ["pokutuna"]
  s.email       = ["popopopopokutuna@gmail.com"]
  s.homepage    = "https://github.com/pokutuna/muplin"
  s.summary     = %q{A pure-ruby application to add (toc|outline) to a PDF file irresponsibly}
  s.description = %q{Muplin is abbrev of MUriyari(irresponsibly force) Pdf outLINer. Muplin adds outlines that consist from pairs of label and page number to a PDF file. see also https://github.com/pokutuna/muplin}

  s.rubyforge_project = "muplin"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency(%q<prawn>, ["~> 0.12.0"])
end
