# -*- encoding: utf-8 -*-
require File.expand_path("../lib/duvet/version", __FILE__)

Gem::Specification.new do |s|
  s.name         = "duvet"
  s.version      = Duvet::VERSION
  s.date         = Time.now.strftime('%Y-%m-%d')
  s.summary      = "Duvet a simple code coverage tool for Ruby 1.9."
  s.homepage     = "http://github.com/hawx/duvet"
  s.email        = "m@hawx.me"
  s.author       = "Joshua Hawxwell"
  s.has_rdoc     = false
  
  s.required_ruby_version = '>= 1.9'
  
  s.files        = %w(README.md Rakefile LICENSE)
  s.files       += Dir["{bin,lib,man,spec}/**/*"] & `git ls-files -z`.split(" ")
  s.test_files   = Dir["spec/**/*"]
  
  s.require_path = 'lib'
  
  s.description  = <<-EOD
    A simple code coverage tool for Ruby 1.9. Add 'Duvet.start' to the top
    of your test helper, to have it write code coverage stuff to 'cov/'.
  EOD
  
  s.add_dependency 'haml', '~> 3.0.25'
  s.add_development_dependency 'thoughtbot-shoulda', '>= 0'
end
  
