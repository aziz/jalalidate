require 'rubygems'

spec = Gem::Specification.new do |s|
	s.name = "JalaliDate"
	s.version = "0.1.0"
	s.author = "Aziz Ashofte Bargi"
	s.email = "aziz.bargi@gmail.com"
	s.rubyforge_project = 'JalaliDate'	
	s.homepage = "http://jalalidate.rubyforge.org"
	s.summary = "A port of class Date in ruby that works based on Jalali Calendar (a.k.a Persian Calendar)"
	s.platform = Gem::Platform::RUBY
	s.files = ["lib/jalali_date.rb", "test/test.rb"]
	s.require_path = "lib"
	s.test_file = "test/test.rb"
	s.has_rdoc = true
	s.extra_rdoc_files = ["README","CHANGELOG","TODO","MIT-LICENSE"]
end

if $0 == __FILE__
	Gem::manage_gems
	Gem::Builder.new(spec).build
end