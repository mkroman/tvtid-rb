$:.unshift File.join(__dir__, '../library')
require 'tvtid'
require 'rspec/its'

def load_json_fixture filename
  Oj.load_file File.join(__dir__, 'tvtid/fixtures', filename)
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
