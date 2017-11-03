
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omnibar/version"

Gem::Specification.new do |spec|
  spec.name          = 'omnibar'
  spec.version       = Omnibar::VERSION
  spec.authors       = ['Jacob Evan Shreve']
  spec.email         = ['shreve@umich.edu']

  spec.summary       = 'A command line butler'
  spec.description   = 'Ask omnibar, and ye shall receive'
  spec.homepage      = 'https://github.com/shreve/omnibar'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
end
