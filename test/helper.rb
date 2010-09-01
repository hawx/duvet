$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'duvet'

require 'rubygems'
require 'test/unit'
require 'shoulda'

class Test::Unit::TestCase
end