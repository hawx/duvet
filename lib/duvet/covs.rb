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
  
  def write(dir='cov', style='rcov')
    self.each do |i|
      i.write(dir)
    end
    write_styles(dir, style)
  end
  
  def write_styles(dir='cov', style='rcov')
    @styles = {'rcov' => File.dirname(__FILE__) + '/styles/rcov.sass'}
    write_path = dir.to_p + 'styles.css'
    
    f = File.new(write_path, "w")
    template = File.read(@styles[style])
    f.write(Sass::Engine.new(template).render)
  end

end
