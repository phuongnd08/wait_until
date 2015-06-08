# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wait_until/version"

Gem::Specification.new do |s|
  s.name = "wait_until"
  s.version = ::WaitUntil::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Matthew Ueckerman"]
  s.summary = %q{Suspends execution until state changes via ::Wait.until! methods}
  s.description = %q{Suspends execution until state changes via ::Wait.until! methods, timing-out after a configured period of time}
  s.email = %q{matthew.ueckerman@myob.com}
  s.homepage = "http://github.com/MYOB-Technology/wait_until"
  s.rubyforge_project = "wait_until"
  s.license = "MIT"

  s.files        = Dir.glob("./lib/**/*")
  s.test_files   = Dir.glob("./spec/**/*")
  s.require_path = "lib"

  s.required_ruby_version = ">= 1.9.3"

  s.add_development_dependency "travis-lint", "~> 2.0"
  s.add_development_dependency "metric_fu", "~> 4.11"
  s.add_development_dependency "rspec", "~> 3.2"
  s.add_development_dependency "rake", "~> 10.4"
  s.add_development_dependency "simplecov", "~> 0.10"
end
