require 'bundler'
Bundler::GemHelper.install_tasks

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.main = 'README.md'
  rdoc.rdoc_dir = 'doc'
  rdoc.rdoc_files.include('README.md', 'lib')
end

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r cfoundry_client.rb'
end