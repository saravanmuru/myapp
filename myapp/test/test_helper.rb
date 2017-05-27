$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start
require 'myapp'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'support/run_command_helpers'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
#
# run_command('myapp server') do |console|
#   run_command('myapp client')
#
#   console.must_match(/client:.*\s+connect/)
#   console.must_match(/client:.*post.*\d+\s+bytes/)
#   console.must_match(/client:.*\+disconnect/)
# end
#
