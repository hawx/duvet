module Duvet
  class Cov
    attr_accessor :cov, :path
    
    def initialize(path, cov)
      if path.include?(Dir.pwd)
        @path = path.to_p.relative_path_from(Pathname.pwd)
      else
        @path = path.to_p
      end

      @cov = cov
      write
    end
    
    # @return [Integer] number of lines in file
    def lines
      @cov.length
    end
    
    # @return [Array] all lines which can be executed
    def code_lines
      @cov.reject {|i| i.nil?}
    end
    
    # @return [Integer] number of lines of code that can be executed
    def lines_of_code
      code_lines.length
    end
    
    # Gives a fraction from 0 to 1 of how many lines of code have 
    # been executed. It ignores all lines that couldn't be executed
    # such as comments.
    #
    # @return [Integer] lines of code executed as a fraction
    def code_coverage
      ran_lines = code_lines.reject {|i| i.zero?}.length
      ran_lines.to_f / lines_of_code.to_f
    end
    
    # @return [String] #code_coverage as ??.??%
    def code_coverage_percent
      "%.2f%" % (code_coverage*100)
    end
    
    # Similar to #code_coverage but counts all lines, executable
    # or not.
    #
    # @return [Integer] lines executed as a fraction
    def total_coverage
      ran_lines = @cov.reject {|i| i.nil? || i.zero?}.length
      ran_lines.to_f / lines.to_f
    end
    
    # @return [String] #total_coverage as ??.??%
    def total_coverage_percent
      "%.2f%" % (total_coverage*100)
    end
    
    # Creates a report showing the source code.
    #
    # @return [String] a report showing line number, source and 
    #   times run
    def source_report
      source = @path.readlines
      str = ""
      source.zip(@cov).each_with_index do |a, i|
        line, count = a[0], a[1]
        str << "#{i}| #{line.gsub("\n", "")}"
        str << " #=> #{count}" if count
        str << "\n"
      end
      str
    end
    
    # @return [String]
    def report
      str = "For #{@path}\n\n" << source_report << "\n"
      str << "total coverage: #{total_coverage}\n"
      str << "code coverage:  #{code_coverage}\n"
      str
    end
    
    # @return [Hash] a hash of data for templating
    def data
      {
        "file" => {
          "path" => @path,
          "url" => @path.file_name + '.html',
          "source" => @path.readlines,
          "lines" => lines,
          "lines_code" => lines_of_code
        },
        "coverage" => {
          "code" => code_coverage_percent,
          "total" => total_coverage_percent,
          "lines" => @cov
        }
      }
    end
    
    # Formats the coverage for the file to be written to a html
    # file, then viewed in a web browser.
    #
    # @return [String]
    def format
      template = File.read(File.join( File.dirname(__FILE__), "templates", "file.erb" ))
      e = Erubis::Eruby.new(template).result(Duvet.template_hash.merge(self.data))
      e
    end
    
    def write(dir='cov')
      f = File.new((dir.to_p + @path.file_name).to_s + '.html', "w" )
      f.write(format)
    end
  
  end
end