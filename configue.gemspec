# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "configue"
  s.authors       = ["hosim"]
  s.email         = ["github.hosim@gmail.com"]
  s.description   = "Configue is a simple configuration solution."
  s.summary       = "A simple configuration solution"
  s.homepage      = "https://github.com/hosim/configue"
  s.executables   = `git ls-files -- bin/*`.split("\n").map {|f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.version       = "0.1.5"
  s.license       = "MIT"

  s.add_development_dependency 'rspec'
end
