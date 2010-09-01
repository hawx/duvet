module Duvet
  class Cov
    attr_accessor :path
    
    def initialize(path, cov)
      if path.include?(Dir.pwd)
        @path = path.to_p.relative_path_from(Pathname.pwd)
      else
        @path = path.to_p
      end

      @cov = cov
      write
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
    # @return [Integer] lines of code executed as a fraction
    def code_coverage
      ran_lines.size.to_f / code_lines.size.to_f
    end

    # Similar to #code_coverage but counts all lines, executable
    # or not.
    #
    # @return [Integer] lines executed as a fraction
    def total_coverage
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
      str << "total coverage: #{total_coverage_percent}\n"
      str << "code coverage:  #{code_coverage_percent}\n"
      str
    end
    
    # @return [Hash] a hash of data for templating
    def data
      {
        "file" => {
          "path" => @path,
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