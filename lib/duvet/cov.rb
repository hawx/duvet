module Duvet

  # A single file along with coverage data.
  class Cov
    attr_accessor :path

    def initialize(path, cov)
      @path = Pathname.new(path)
      if @path.to_s.include?(Dir.pwd)
        @path = @path.relative_path_from(Pathname.getwd)
      end

      @cov = cov
    end

    # @return [Array] Coverage data of lines in the file
    def lines
      @cov
    end

    # @return [Array] Coverage data for all the lines which can be executed
    def code_lines
      lines.reject {|i| i.nil?}
    end

    # @return [Array] Coverage data for all the lines which have been ran
    def ran_lines
      code_lines.reject {|i| i.zero?}
    end

    # Gives a real number between 0 and 1 indicating how many lines have been
    # executed.
    #
    # @return [Float] lines executed as a fraction
    def total_coverage
      return 0.0 if lines.size.zero?
      ran_lines.size.to_f / lines.size.to_f
    end

    # Gives a real number between 0 and 1 indicating how many lines of code have
    # been executed. It ignores all lines that can not be executed such as
    # comments.
    #
    # @return [Float] lines of code executed as a fraction
    def code_coverage
      return 0.0 if code_lines.size.zero?
      ran_lines.size.to_f / code_lines.size.to_f
    end

    # @param [Float] Number to format
    # @return [String] The number formatted as a percentage, ??.??%
    def percent(num)
      "%.2f%" % (num * 100)
    end

    # @return [String] A simple text report of coverage
    def report
      <<EOS
#{@path}
  total: #{percent(total_coverage)}
  code:  #{percent(code_coverage)}
EOS
    end

    # @return [Hash] Data for templating
    def data
      {
        file: {
          path:   @path.to_s,
          url:    @path.to_s[0..-@path.extname.size] + 'html',
          root:   '../' * @path.to_s.count('/'),
          source: @path.readlines,
        },
        lines: {
          total:  lines.size,
          code:   code_lines.size,
          ran:    ran_lines.size
        },
        coverage: {
          code:   percent(code_coverage),
          total:  percent(total_coverage),
          lines:  lines
        }
      }
    end

    # Writes the file
    def write
      Duvet.write data, 'html/file.erb'
    end

  end
end
