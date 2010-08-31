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


module Duvet

  # Start tracking
  def start
    Coverage.start
    running = true
  end
  
  # Get result
  def result
    Cov.new(Coverage.result) if running
  end
  
  # Write results
  def write
    result.write
  end

end
