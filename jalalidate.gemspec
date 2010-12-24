# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jalalidate/version"

Gem::Specification.new do |s|
  s.name                      = "jalalidate"
  s.version                   = Jalalidate::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.authors                   = ["Allen A. Bargi"]
  s.email                     = %q{allen.bargi@gmail.com}
  s.homepage                  = %q{http://github.com/aziz/jalalidate}
  s.summary                   = %q{A library for working with Jalali Calendar (a.k.a Persian Calendar)}
  s.description               = %q{A library for working with Jalali Calendar (a.k.a Persian Calendar)}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubyforge_project         = "jalalidate"
  s.executables               = ["jdate"]
  s.files                     = `git ls-files`.split("\n")
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables               = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths             = ["lib"]
  s.extra_rdoc_files          = [ "LICENSE", "README.md"]
  s.rdoc_options              = ["--charset=UTF-8"]
  s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
  s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
end
