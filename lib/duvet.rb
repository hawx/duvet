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
require 'erb'

require 'duvet/cov'

# Start the code coverage
Coverage.start

# Require the files we care about
require 'lib/test'

# Print out the results
c = Cov.new(Coverage.result)
c.report
