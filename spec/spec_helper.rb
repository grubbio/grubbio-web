ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'rubygems'
require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
require 'spork'
require 'haml'
#uncomment the following line to use spork with the debugger
# require 'spork/ext/ruby-debug'
# require 'devise/mock'
require_relative "support/mock_devise"

Spork.prefork do

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  SimpleCov.start 'rails' if ENV['COVERAGE']
  ENV["RAILS_ENV"] ||= 'test'
  # ENV['USE_SET_SCHEMA'] = 'false'

  # require File.expand_path('../../features/support/routing', __FILE__)

  # # Requires supporting ruby files with custom matchers and macros, etc,
  # # in spec/support/ and its subdirectories.
  # ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
  # Dir[File.join(ENGINE_RAILS_ROOT, 'features/support/**/*.rb')].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    config.include FactoryGirl::Syntax::Methods

    config.color_enabled = true
    config.order = :random
    config.formatter = :documentation

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
    # config.include Devise::TestHelpers, :type => :controller

    config.order = "random"
    
    config.include Rails.application.routes.url_helpers
  end
  
  class ApplicationController < ActionController::Base
    include MockDevise
  end
end
#
Spork.each_run do
  puts "\n\nSpork start time: #{Time.now.strftime("%I:%M:%S %p, %m/%d/%Y")}\n\n"
end
