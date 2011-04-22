module Duvet
  class Cov
    attr_accessor :path
    
    def initialize(path, cov)
      @path = Pathname.new(path)
      if @path.to_s.include?(Dir.pwd)
        a = Dir.pwd.size + 1
        @path = Pathname.new(path[a..-1])
        #@path = @path.relative_path_from(Pathname.getwd)
      end
      
      @cov = cov
    end
    
    # @return [Array] lines in file
    def lines
      @cov
    end
    
    # @return [Array] all lines which can be executed
    def code_lines
      @cov.reject {|i| i.nil?}
    end
    
    # @return [Array] all lines which have been ran
    def ran_lines
      @cov.reject {|i| i.nil? || i.zero?}
    end
    
    # Gives a fraction from 0 to 1 of how many lines of code have 
    # been executed. It ignores all lines that couldn't be executed
    # such as comments.
    #
    # @return [Float] lines of code executed as a fraction
    def code_coverage
      return 0.0 if code_lines.size.zero?
      ran_lines.size.to_f / code_lines.size.to_f
    end

    # Similar to #code_coverage but counts all lines, executable
    # or not.
    #
    # @return [Integer] lines executed as a fraction
    def total_coverage
      return 0.0 if lines.size.zero?
      ran_lines.size.to_f / lines.size.to_f
    end
    
    # @return [String] #code_coverage as ??.??%
    def code_coverage_percent
      "%.2f%" % (code_coverage*100)
    end
    
    # @return [String] #total_coverage as ??.??%
    def total_coverage_percent
      "%.2f%" % (total_coverage*100)
    end
    
    # @return [String]
    def report
      str = "#{@path}\n"
      str << "  total: #{total_coverage_percent}\n"
      str << "  code:  #{code_coverage_percent}\n\n"
      str
    end
    
    # @return [Hash] a hash of data for templating
    def data
      {
        "file" => {
          "path" => @path.to_s,
          "url" => @path.file_name + '.html',
          "source" => @path.readlines,
          "lines" => lines.size,
          "lines_code" => code_lines.size,
          "lines_ran" => ran_lines.size
        },
        "coverage" => {
          "code" => code_coverage_percent,
          "total" => total_coverage_percent,
          "lines" => lines
        }
      }
    end
    
    # Formats the coverage for the file to be written to a html
    # file, then viewed in a web browser.
    #
    # @return [String]
    def format
      template = File.read File.join(TEMPLATE_PATH, 'html', 'file.haml')
      haml_engine = Haml::Engine.new(template)
      output = haml_engine.render(nil, Duvet.template_hash.merge(self.data))
      output
    end
    
    def write(dir='cov')
      pa = (dir.to_p + @path.file_name).to_s + '.html'
      File.new(pa, 'w')
      File.open(pa, 'w') {|f| f.puts(self.format) }
    end
  
  end
end