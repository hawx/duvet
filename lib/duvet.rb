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

  attr_accessor :opts

  # Start tracking
  def self.start(opts)
    @opts = opts
  
    Coverage.start
    @running = true
  end
  
  # Get result
  def self.result
    @result ||= Duvet::Covs.new(Coverage.result) if running?
  ensure
    @running = false
  end
  
  # Write results
  def self.write
    self.result.write(@opts[:dir], @opts[:style]) if running?
  end
  
  # Proc to call when exiting
  # @todo Allow user to override block used
  def self.at_exit
    Proc.new { self.write }
  end
  
  # @return [Boolean] whether coverage is running
  def self.running?
    @running
  end

end

at_exit do
  Duvet.at_exit.call
end
