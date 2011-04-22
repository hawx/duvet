$: << File.join(File.dirname(__FILE__), '..')

# Add this to test/helper.rb at the before __anything__ else
#
#   require 'duvet'
#   Duvet.start
#
require 'coverage'
require 'ostruct'
require 'pathname'
require 'haml'
require 'sass'

require 'duvet/core_ext'
require 'duvet/covs'
require 'duvet/cov'
require 'duvet/version'

module Duvet

  attr_accessor :opts
  
  DEFAULTS = {:dir => 'cov', :style => 'rcov'}
  
  TEMPLATE_PATH = File.join File.dirname(__FILE__), '..', 'templates'

  # Start tracking
  def self.start(opts={})
    @opts = DEFAULTS.merge(opts)
    
    Coverage.start
    @running = true
  end
  
  # Get result
  def self.result
    cov = Coverage.result if running?
    if @opts[:filter]
      filtered = {}
      cov.each do |k, v|
        if k.include?(@opts[:filter])
          filtered[k] = v
        end
      end
      cov = filtered
    end
    @result ||= Duvet::Covs.new(cov)
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
  
  # @return [Hash] hash to merge for templating
  def self.template_hash
    {
      'time' => Time.now,
      'version' => VERSION,
      'name' => 'duvet'
    }
  end

end

at_exit do
  Duvet.at_exit.call
end
