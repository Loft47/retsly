$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
SPEC_PATH = Dir.pwd
require 'pry'
require 'retsly'
require 'webmock/rspec'
require_relative './helpers/retsly_mock'

RSpec.configure do |config|
  config.include Helpers
end
