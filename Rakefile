require 'rubygems'
require 'rake'

desc 'Default: run unit tests'
task :default => :test
begin
  require 'rspec'
  require 'rspec/core/rake_task'
  desc 'Run the unit tests'
  RSpec::Core::RakeTask.new(:test)
rescue LoadError
  task :test do
    raise "You must have rspec 2.0 installed to run the tests"
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "metric_abc_report"
    gem.summary = "Quick and *DIRTY* reports for Metric ABC"
    gem.description = "Generates code complexity reports for Metric ABC in a variety of formats"
    gem.email = "greg_burghardt@yahoo.com"
    gem.homepage = "http://github.com/gburghardt/metric_abc_report"
    gem.authors = ["Greg Burghardt"]
    gem.files = FileList['lib/**/*', 'spec/**/*', 'bin/**/*', 'README.rdoc']
    gem.add_development_dependency 'metric_abc', '~>0.0.3'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
