$:.push File.expand_path("lib", __dir__)
require "wait_until/version"

Gem::Specification.new do |spec|
  spec.name = "wait_until"
  spec.version = ::WaitUntil::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = %w{ dueckes }
  spec.summary = %q{Suspends execution until state changes via ::Wait.until! methods}
  spec.description = %q{Suspends execution until state changes via ::Wait.until! methods, timing-out after a configured period of time}
  spec.email = %q{matthew.ueckerman@myob.com}
  spec.homepage = "http://github.com/MYOB-Technology/wait_until"
  spec.rubyforge_project = "wait_until"
  spec.license = "MIT"

  spec.files        = Dir.glob("./lib/**/*")
  spec.test_files   = Dir.glob("./spec/**/*")

  spec.require_path = "lib"

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "rubocop",     "~> 0.71"
  spec.add_development_dependency "rspec",       "~> 3.8"
  spec.add_development_dependency "rake",        "~> 12.3"
  spec.add_development_dependency "simplecov",   "~> 0.16"
  spec.add_development_dependency "travis-lint", "~> 2.0"
end
