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
  def self.start
    Coverage.start
    @running = true
  end
  
  # Get result
  def self.result
    Duvet::Covs.new(Coverage.result) if running?
  ensure
    @running = false
  end
  
  # Write results
  def self.write
    self.result.write if running?
  end
  
  def self.at_exit
    Proc.new { self.write }
  end
  
  def self.running?
    @running
  end

end

at_exit do
  Duvet.at_exit.call
end
