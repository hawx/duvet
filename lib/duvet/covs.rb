module Duvet
  class Covs < Array
  
    def initialize(cov)
      replace []
      cov.each do |p, c|
        self << Cov.new(p, c)
      end
    end
  
    def report
      self.each do |i|
        puts i.report
      end
    end
    
    def format
      self.each do |i|
        puts i.format
      end
    end
    
    
  # @group Totals
    
    # @return [Integer]
    def total_lines
      self.inject(0) {|a, e| a + e.cov.length }
    end
    
    # @return [Integer]
    def total_code_lines
      self.inject(0) {|a, e| a + e.lines_of_code }
    end
    
    # @return [Integer]
    def total_total_cov
      "%.2f%" % (self.inject(0) {|a, e| a + e.total_coverage*100 } / self.size)
    end
    
    # @return [Integer]
    def total_code_cov
      "%.2f%" % (self.inject(0) {|a, e| a + e.code_coverage*100 } / self.size)
    end
    
  # @endgroup
    
    
    def data
      r = []
      self.each do |i|
        r << i.data
      end
      {
        'files' => r,
        'total' => {
          'lines' => total_lines,
          'lines_code' => total_code_lines,
          'total_cov' => total_total_cov,
          'code_cov' => total_code_cov
        }
      }
    end
    
    def format(dir='cov')
      template = File.read(File.join( File.dirname(__FILE__), "templates", "index.erb" ))
      e = Erubis::Eruby.new(template).result(self.data)
      e
    end
    
    def write(dir='cov', style='rcov')
      if self.size > 0
        FileUtils.mkdir_p dir
      
        f = File.new( dir.to_p + 'index.html', "w")
        f.write(format)
        
        self.each do |i|
          i.write(dir)
        end
        write_styles(dir, style)
      else
        p "no files"
      end
    end
    
    def write_styles(dir='cov', style='rcov')
      @styles = {'rcov' => File.dirname(__FILE__) + '/styles/rcov.sass'}
      write_path = dir.to_p + 'styles.css'
      
      f = File.new(write_path, "w")
      template = File.read(@styles[style])
      f.write(Sass::Engine.new(template).render)
    end
  
  end
end
