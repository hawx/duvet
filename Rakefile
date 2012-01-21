require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end


task :build do
  require 'sass'
  path = File.dirname(__FILE__) + '/templates/css/'
  content = Sass::Engine.new(IO.read(path + 'styles.sass')).render

  File.open path + 'styles.css', 'w' do |f|
    f.write content
  end
end

task :default => :test
