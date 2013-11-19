require 'bundler'
Bundler.require(:development)

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"
  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require_relative "../lib/wait_until"

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }
