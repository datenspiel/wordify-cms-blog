EXTENSION_ROOT  = File.expand_path('../..',__FILE__)
SPEC_ROOT       = File.expand_path('..', __FILE__)
DUMMY_ROOT      = File.expand_path("../dummy", __FILE__)

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require "wordify.cms"
require 'database_cleaner'
require 'mongoid-rspec'
require 'fabrication'
require 'ffaker'

Dir[File.join(EXTENSION_ROOT, "app", "**", "*.rb")].each{ |file| require file }
Dir[File.join(SPEC_ROOT, "support", "**","*.rb")].each do |file|
  require file
end
Dir[File.join(SPEC_ROOT, "fabricators/**/*.rb")].each {|fab| require fab }

FileUtils.ln_sf(File.expand_path(File.join(EXTENSION_ROOT, '..', 'wordify_blog')),
                "#{DUMMY_ROOT}/lib/wordify.cms/extensions/wordify_blog")

RSpec.configure do |config|
  config.include Devise::TestHelpers,                       :type => :controller
  config.include Mongoid::Matchers
  config.extend WordifyCms::RSpec::Controller,              :type => :controller
  config.include WordifyCms::Blog::RSpec::SharedExamples,   :type => :controller

  config.before(:suite) do
    FileUtils.rm_rf(File.expand_path("../wordify_blog",SPEC_ROOT))
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.after do
    #FileUtils.rm_rf("#{DUMMY_ROOT}/lib/wordify.cms/extensions/wordify_blog")
  end

  config.before do
    Mongoid.load!("#{DUMMY_ROOT}/config/mongoid.yml", :test)
    DatabaseCleaner.clean
  end
end