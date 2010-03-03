require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|

    gem.name = "jalalidate"
    gem.version = "0.2.0"
    gem.authors = ["Aziz A. Bargi"]
    gem.email = "aziz.bargi@gmail.com"
    gem.rubyforge_project = 'JalaliDate'  
    gem.homepage = "http://github.com/aziz/jalalidate"
    gem.summary = "A port of class Date in ruby that works based on Jalali Calendar (a.k.a Persian Calendar)"
    gem.require_path = "lib"
    gem.has_rdoc = true
    gem.extra_rdoc_files = ["README.rdoc","LICENSE"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.rdoc_options << "--charset" << "utf-8"    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.options << "--charset" << "utf-8"
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "jalalidate #{version}"
  rdoc.rdoc_files.include(['README.rdoc','LICENSE'])
  rdoc.rdoc_files.include('lib/**/*.rb')
end
