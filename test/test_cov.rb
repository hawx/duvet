require_relative 'helper'

class TestCov < MiniTest::Unit::TestCase

  def setup
    @lines = [5, 2, nil, 2, 4, 3, 0, 0, 0, nil]
    @cov = Duvet::Cov.new('test_duvet/lib/klass.rb', @lines)
  end
  
  def test_cleans_path
    cov = Duvet::Cov.new(Dir.pwd + '/test.rb', @lines)
    assert_equal Pathname.new('test.rb'), cov.path
  end
  
  def test_has_lines
    assert_equal @lines, @cov.lines
  end
  
  def test_has_executed_lines
    assert_equal [5, 2, 2, 4, 3, 0, 0, 0], @cov.code_lines
  end
  
  def test_has_ran_lines
    assert_equal [5, 2, 2, 4, 3], @cov.ran_lines
  end
  
  def test_gives_code_coverage_as_decimal
    assert_equal 0.625, @cov.code_coverage
  end
  
  def test_gives_code_coverage_as_percentage
    assert_equal "62.50%", @cov.code_coverage_percent
  end
  
  def test_gives_coverage_as_decimal
    assert_equal 0.5, @cov.total_coverage
  end
  
  def test_gives_coverage_as_percentage
    assert_equal "50.00%", @cov.total_coverage_percent
  end
  
  def test_creates_report
    assert_equal "test_duvet/lib/klass.rb\n  total: 50.00%\n  code:  62.50%\n\n", @cov.report
  end
  
  def test_has_data_hash
    file_data = @cov.data['file']
    assert_equal 'test_duvet/lib/klass.rb', file_data['path']
    assert_equal 'klass.html', file_data['url']
    # assert_equal '', @path.readlines
    assert_equal 10, file_data['lines']
    assert_equal 8, file_data['lines_code']
    assert_equal 5, file_data['lines_ran']
    
    cov_data = @cov.data['coverage']
    assert_equal "62.50%", cov_data['code']
    assert_equal "50.00%", cov_data['total']
    assert_equal @lines, cov_data['lines']
  end
  
  def test_renders_with_template
    stub.proxy(::Erubis::Eruby).new do |obj|
      stub(obj).result { "yeah" }
      obj
    end

    assert_equal @cov.format, "yeah"
  end
  
  def test_writes_file
    stub(File).open("/dev/null/klass.html", 'w')
    @cov.write(Pathname.new("/dev/null"))
  end

end