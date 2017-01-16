$:.unshift File.join(__dir__, '../library')
require 'tvtid'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
