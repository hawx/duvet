# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{duvet}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Hawxwell"]
  s.date = %q{2010-11-27}
  s.default_executable = %q{duvet}
  s.description = %q{Duvet a simple code coverage tool for ruby 1.9}
  s.email = %q{m@hawx.me}
  s.executables = ["duvet"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/duvet",
    "duvet.gemspec",
    "lib/duvet.rb",
    "lib/duvet/cov.rb",
    "lib/duvet/covs.rb",
    "lib/duvet/ext.rb",
    "templates/css/dark.sass",
    "templates/css/light.sass",
    "templates/css/rcov.sass",
    "templates/html/file.haml",
    "templates/html/index.haml",
    "templates/js/jquery.js",
    "templates/js/main.js",
    "templates/js/plugins.js",
    "test/helper.rb",
    "test/test_duvet.rb",
    "test_duvet/lib/klass.rb",
    "test_duvet/lib/run.rb",
    "test_duvet/test/test_all.rb"
  ]
  s.homepage = %q{http://github.com/hawx/duvet}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Duvet a simple code coverage tool for ruby 1.9}
  s.test_files = [
    "test/helper.rb",
    "test/test_duvet.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

