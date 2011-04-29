# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scratch/version"

Gem::Specification.new do |s|
  s.name        = "scratch"
  s.version     = Scratch::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nate Sutton"]
  s.email       = ["nate@zencoder.com"]
  s.homepage    = "http://rubydoc.info/github/nate/scratch"
  s.summary     = %q{Easily use and manage scratch files for throwaway programming.}
  s.description = %q{Easily use and manage scratch files for throwaway programming.}

  s.rubyforge_project = "scratch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
