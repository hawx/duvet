# -*- encoding: utf-8 -*-
require File.expand_path("../lib/duvet/version", __FILE__)

Gem::Specification.new do |s|
  s.name         = "duvet"
  s.author       = "Joshua Hawxwell"
  s.email        = "m@hawx.me"
  s.summary      = "Duvet is a simple code coverage tool for Ruby 1.9."
  s.homepage     = "http://github.com/hawx/duvet"
  s.version      = Duvet::VERSION
  
  s.description  = <<-EOD
    A simple code coverage tool for Ruby 1.9. Add 'Duvet.start' to the top
    of your test helper, to have it write code coverage stuff to 'cov/'.
  EOD
  
  s.required_ruby_version = '>= 1.9'
  s.add_dependency 'erubis', '>= 2.7'
  s.add_dependency 'sass', '>= 3.1'
  s.add_development_dependency 'rr', '>= 1.0.2'
  
  s.files        = %w(README.md Rakefile LICENSE)
  s.files       += Dir["{lib,templates,test}/**/*"] & `git ls-files`.split(" \n")
  s.test_files   = Dir["test/**/*"] & `git ls-files`.split(" \n")
end
