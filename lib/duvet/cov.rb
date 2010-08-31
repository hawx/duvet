module Duvet
  class Cov
    attr_accessor :cov, :path
    
    def initialize(path, cov)
      @path = path
      @cov = cov
      write
    end
    
    # @return [Integer] number of lines of code that can be executed
    def lines_of_code
      @cov.reject {|i| i.nil?}.length
    end
    
    # Gives a fraction from 0 to 1 of how many lines of code have 
    # been executed. It ignores all lines that couldn't be executed
    # such as comments.
    #
    # @return [Integer] lines of code executed as a fraction
    def code_coverage
      c = @cov.reject {|i| i.nil?}
      total_lines = c.length
      ran_lines = c.reject {|i| i.zero?}.length
      ran_lines.to_f / total_lines.to_f
    end
    
    # Similar to #code_coverage but counts all lines, executable
    # or not.
    #
    # @return [Integer] lines executed as a fraction
    def total_coverage
      total_lines = @cov.length
      ran_lines = @cov.reject {|i| i.nil? || i.zero?}.length
      ran_lines.to_f / total_lines.to_f
    end
    
    # Creates a report showing the source code.
    #
    # @return [String] a report showing line number, source and 
    #   times run
    def source_report
      source = File.readlines(@path)
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
          "url" => @path.to_p.file_name.to_s + '.html',
          "source" => File.readlines(@path),
          "lines" => @cov.length,
          "lines_code" => lines_of_code
        },
        "coverage" => {
          "code" => "%.2f%" % (code_coverage*100),
          "total" => "%.2f%" % (total_coverage*100),
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
      e = Erubis::Eruby.new(template).result(self.data)
      e
    end
    
    def write(dir='cov')
      f = File.new( (dir.to_p + @path.to_p.file_name).to_s + '.html', "w" )
      f.write(format)
    end
  
  end
end