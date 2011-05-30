$: << File.dirname(__FILE__)

# Make sure to start coverage so that it generates it for itself
require 'coverage'
Coverage.start

require_relative '../lib/duvet'
Duvet.start :filter => 'lib/duvet'

require 'minitest/mock'
require 'minitest/pride'

require 'rr'
class MiniTest::Unit::TestCase
  include RR::Adapters::TestUnit
end

MiniTest::Unit.autorun

