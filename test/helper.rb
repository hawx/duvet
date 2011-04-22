$: << File.dirname(__FILE__)

# By requiring the test helper coverage can be generated for duvet itself
require_relative '../lib/duvet/test_helper.rb'
Duvet.start :filter => 'lib/duvet'
require_relative '../lib/duvet'

require 'rubygems'
require 'test/unit'
require 'shoulda'

class Test::Unit::TestCase

end