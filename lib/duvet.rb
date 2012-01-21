# Add this to test/helper.rb at the before __anything__ else
#
#   require 'duvet'
#   Duvet.start
#

require 'coverage'
require 'pathname'
require 'erb'
require 'sass'

require 'duvet/covs'
require 'duvet/cov'
require 'duvet/version'

module Duvet
  extend self

  attr_accessor :opts

  DEFAULTS = {
    dir:    'cov',
    style:  'rcov',
    filter: ''
  }

  TEMPLATE_HASH = {
    name:    'duvet',
    time:    Time.now,
    version: VERSION
  }

  TEMPLATE_PATH = Pathname.new(__FILE__).dirname + '..' + 'templates'

  # Start coverage tracking, needs to be called before any files are loaded.
  #
  # @param opts [Hash]
  # @option opts [String, Pathname] :dir Directory to write coverage to
  # @option opts [String, Regexp] :filter Pattern files must match to be written
  def start(opts={})
    @opts = DEFAULTS.merge(opts)
    @opts[:filter] = Regexp.new(@opts[:filter])
    @opts[:dir]    = Pathname.new(@opts[:dir])

    Coverage.start
  end

  # Gets the results from the Coverage, filtered against the patterm given to
  # #start.
  #
  # @return [Covs]
  def result
    cov = Coverage.result.find_all do |path, c|
      @opts[:filter] =~ path
    end

    Duvet::Covs.from_data cov
  end

  # Creates a class with methods for rendering an ERB template.
  #
  # @param obj [Object] Object to create context for
  # @return [#get_binding] Object which gives a binding for ERB templates
  def context_for(obj)
    case obj
    when Array
      obj.map {|i| context_for(i) }
    when Hash
      klass = Class.new
      klass.send(:define_method, :get_binding) { binding }

      obj.each do |k,v|
        klass.send(:define_method, k) { Duvet.context_for(v) }
      end

      klass.new
    else
      obj
    end
  end

  # Renders a template with the data given.
  #
  # @param data [Hash] Data to insert into template
  # @param template [String] Path to template from TEMPLATE_PATH
  def format(data, template)
    t = (TEMPLATE_PATH + template).read
    vars = context_for TEMPLATE_HASH.merge(data)

    ERB.new(t).result(vars.get_binding)
  end

  # Renders then writes a file based on the url in the data given.
  #
  # @param data [Hash] Data to insert into template
  # @param template [String] Path to template from TEMPLATE_PATH
  def write(data, template)
    write_file format(data, template), data[:file][:url]
  end

  # Writes a file, creating directories where necessary.
  #
  # @param text [String] Text to write to file
  # @param path [String] Path to write file to
  def write_file(text, path)
    write_to = @opts[:dir] + path

    FileUtils.mkdir_p write_to.dirname
    File.open write_to, 'w' do |f|
      f.write text
    end
  end

  # Writes all the resources to the correct directory.
  def write_resources
    paths = %w(css/styles.css js/main.js js/jquery.js js/plugins.js)

    paths.each do |path|
      path = Pathname.new(TEMPLATE_PATH + path)
      write_file path.read, path.basename
    end
  end

  # Call this on exit so that coverage is written.
  def finish
    FileUtils.mkdir_p @opts[:dir]
    result.write
    write_resources
  end

end

at_exit do
  Duvet.finish
end
