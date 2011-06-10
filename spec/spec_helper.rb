# Set environment
ENV["RAILS_ENV"] ||= 'test'

# Require basic Rails env
require File.expand_path("../testbed/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'javascript_auto_include'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
end