module Duvet
  class Covs < Array
  
    def initialize(cov)
      self.replace []
      cov.each do |path, c|
        self << Cov.new(path, c)
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
      self.inject(0) {|a, e| a + e.lines.size }
    end
    
    # @return [Integer]
    def total_code_lines
      self.inject(0) {|a, e| a + e.code_lines.size }
    end
    
    # @return [Integer]
    def total_ran_lines
      self.inject(0) {|a, e| a + e.ran_lines.size }
    end
    
    # @return [String] total lines run / total lines, as percentage
    def total_total_cov
      "%.2f%" % (total_ran_lines.to_f / total_lines.to_f*100)
    end
    
    # @return [String] total lines run / total lines of code, as percentage
    def total_code_cov
      "%.2f%" % (total_ran_lines.to_f / total_code_lines.to_f*100)
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
          'lines_ran' => total_ran_lines,
          'total_cov' => total_total_cov,
          'code_cov' => total_code_cov
        }
      }
    end
    
    def format(dir='cov')
      template = File.read File.join(TEMPLATE_PATH, 'html', 'index.haml')
      haml_engine = Haml::Engine.new(template)
      output = haml_engine.render(nil, Duvet.template_hash.merge(self.data))
      output
    end
    
    def write(dir='cov', style='rcov')
      if self.size > 0
        FileUtils.mkdir_p dir
      
        f = File.new( dir.to_p + 'index.html', "w")
        f.write(format)
        
        self.each do |i|
          i.write(dir)
        end
        write_resources(dir, style)
      else
        warn "no files"
      end
    end

    # @todo Allow you to change style used
    def write_resources(dir, style)
      js_dir = File.join(TEMPLATE_PATH, 'js')
      css_dir = File.join(TEMPLATE_PATH, 'css')
    
      Dir.glob("#{css_dir}/*").each do |i|
        if i.include?(style)
          write_path = dir.to_p + 'styles.css'
          f = File.new(write_path, "w")
          f.write Sass::Engine.new( File.read(i) ).render
        end
      end
      
      Dir.glob("#{js_dir}/*").each do |i|
        write_path = dir.to_p + i.to_p.basename
        f = File.new(write_path, "w")
        f.write(File.read(i))
      end

    end
  
  end
end
