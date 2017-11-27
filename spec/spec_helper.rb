$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'jalalidate'
require 'rspec'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end
