$:.unshift File.join(__dir__, '../library')
require 'tvtid'
require 'vcr'
require 'rspec/its'

def load_json_fixture filename
  Oj.load_file File.join(__dir__, 'tvtid/fixtures', filename)
end

VCR.configure do |c|
  c.cassette_library_dir = 'specifications/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
