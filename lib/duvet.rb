# Add this to test/helper.rb at the before __anything__ else
#
#   require 'duvet'
#   Duvet.start
#

require 'coverage'
require 'pathname'
require 'erubis'
require 'sass'

require 'duvet/core_ext'
require 'duvet/covs'
require 'duvet/cov'
require 'duvet/version'

module Duvet

  attr_accessor :opts
  
  DEFAULTS = {:dir => 'cov', :style => 'rcov'}
  
  TEMPLATE_PATH = Pathname.new(__FILE__).dirname + '..' + 'templates'
  
  TEMPLATE_HASH = {
    'time' => Time.now,
    'version' => VERSION,
    'name' => 'duvet'
  }

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
      @opts[:filter] = /#{@opts[:filter]}/ unless @opts[:filter].is_a?(Regexp)
      cov.each do |k, v|
        if @opts[:filter] =~ k
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
    self.result.write(Pathname.new(@opts[:dir])) if running?
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
