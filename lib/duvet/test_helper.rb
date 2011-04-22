# Allows duvet to generate it's own code coverage

require 'coverage'

module Duvet

  DEFAULTS = {:dir => 'cov', :style => 'rcov'}

  def self.start(opts={})
    @opts = DEFAULTS.merge(opts)
    
    Coverage.start
    @running = true
  end

end