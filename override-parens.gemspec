lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  version = "0.0.1"

  s.name          = "override-parens"
  s.version       = version
  s.platform      = Gem::Platform::RUBY
  s.license       = "MIT"
  s.authors       = ["Ben Christel"]
  s.homepage      = "http://github.com/benchristel/override-parens"
  s.summary       = "override-parens-#{version}"
  s.description   = "Add the method call operator (parentheses) to classes and modules, e.g. MyClass(foo)"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(/^test/)
  s.require_paths = ["lib"]
end
