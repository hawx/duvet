class Cov
  attr_accessor :files

  def initialize(cov)
    @files = []
    cov.each do |p, c|
      @files << CovFile.new(p, c)
    end
  end
  
  def report
    @files.each do |i|
      puts i.report
    end
  end
  
  # Stores coverage for a certain file
  class CovFile
    attr_accessor :cov, :path
    
    def initialize(path, cov)
      @path = path
      @cov = cov
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
    
  end
end