require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "javascript_auto_include"
  gem.homepage = "http://github.com/paceline/javascript_auto_include"
  gem.license = "MIT"
  gem.summary = "Rails helper for automatically including javascript files"
  gem.description = "Rails helper for automatically including javascript files. Looks up assets in public/javascripts based on the current controller/action pair."
  gem.email = "hello@ulfmoehring.net"
  gem.authors = ["Ulf Moehring"]
  gem.add_runtime_dependency 'actionpack', '>= 3.0.0'
end
Jeweler::RubygemsDotOrgTasks.new
