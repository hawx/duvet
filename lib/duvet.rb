$:.unshift File.dirname(__FILE__)

# Add this to test/helper.rb
# require 'coverage'
#
# Coverage.start
#
# at_exit do
#   p Coverage.result
# end
#
require 'coverage'
require 'ostruct'
require 'erubis'
require 'pathname'
require 'sass'

require 'duvet/ext'
require 'duvet/covs'
require 'duvet/cov'
