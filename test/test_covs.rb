require_relative 'helper'

class TestCovs < MiniTest::Unit::TestCase

  def setup
    @files = {
      'test_duvet/lib/run.rb' => [3, 2, 1, 0, nil],
      'test_duvet/lib/klass.rb' => [nil, nil, 0, 1, 2]
    }
    @covs = Duvet::Covs.new(@files)
  end
  
  def test_creates_cov_instances
    assert_kind_of Array, @covs
    @covs.each do |i|
      assert_kind_of Duvet::Cov, i
    end
  end
  
  def test_creates_report
    report = <<EOS
test_duvet/lib/run.rb
  total: 60.00%
  code:  75.00%

test_duvet/lib/klass.rb
  total: 40.00%
  code:  66.67%

EOS
  
    assert_equal report, @covs.report
  end
  
  def test_has_data_hash
    assert_kind_of Array, @covs.data['files']
  end
  
  def test_renders_with_template
    stub.proxy(::Erubis::Eruby).new do |obj|
      stub(obj).result { "yeah" }
      obj
    end
    
    assert_equal "yeah", @covs.format
  end
  
  def test_writes_files
    dir = Pathname.new("tmp")
  
    stub(FileUtils).mkdir_p(dir)
    stub(File).open(dir + 'index.html', 'w')
    
    @covs.each {|i| stub(i).write(dir) }
    stub(@covs).write_resources(dir)
    
    @covs.write(dir)
  end
  
  def test_warns_if_no_files_to_write
    empty_covs = Duvet::Covs.new({})
    assert_output nil, "No files to create coverage for.\n" do
      empty_covs.write(nil)
    end
  end

end