module Duvet
  class Covs < Array
  
    def initialize(cov)
      self.replace []
      cov.each do |path, c|
        self << Cov.new(path, c)
      end
    end
  
    def report
      map {|i| i.report }.join('')
    end
    
    def data
      { 'files' => map {|i| i.data } }
    end
    
    def format
      template = (TEMPLATE_PATH + 'html' + 'index.haml').read
      haml_engine = Haml::Engine.new(template)
      haml_engine.render(nil, TEMPLATE_HASH.merge(self.data))
    end
    
    def write(dir)
      if size > 0
        FileUtils.mkdir_p(dir)
        File.open(dir + 'index.html', 'w') {|f| f.write(format) }
        
        each {|c| c.write(dir) }
        
        write_resources(dir)
      else
        warn "No files to create coverage for."
      end
    end

    # @todo Allow you to change style used
    def write_resources(dir)
      Pathname.glob(TEMPLATE_PATH + 'css' + '*').each do |i|
        f = File.new(dir + 'styles.css', 'w')
        f.write Sass::Engine.new(i.read).render
      end

      Pathname.glob(TEMPLATE_PATH + 'js' + '*').each do |i|
        f = File.new(dir + i.basename, 'w')
        f.write(i.read)
      end
    end
  
  end
end
