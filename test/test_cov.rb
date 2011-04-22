require 'helper'

class TestCov < Test::Unit::TestCase

  context "Loaded coverage for a file" do
  
    setup do
      @lines = [5, 2, nil, 2, 4, 3, 0, 0, 0, nil]
      @cov = Duvet::Cov.new('test_duvet/lib/klass.rb', @lines)
    end
    
    should "give all lines" do
      assert_equal @lines, @cov.lines
    end
    
    should "give lines which can be executed" do
      assert_equal [5, 2, 2, 4, 3, 0, 0, 0], @cov.code_lines
    end
    
    should "give lines which were ran" do
      assert_equal [5, 2, 2, 4, 3], @cov.ran_lines
    end
    
    should "give code coverage as decimal" do
      assert_equal 0.625, @cov.code_coverage
    end
    
    should "give code coverage as percentage" do
      assert_equal "62.50%", @cov.code_coverage_percent
    end
    
    should "give coverage across whole file as decimal" do
      assert_equal 0.5, @cov.total_coverage
    end
    
    should "give total coverage as percentage" do
      assert_equal "50.00%", @cov.total_coverage_percent
    end
    
    should "give a report" do
      assert_equal "test_duvet/lib/klass.rb\n  total: 50.00%\n  code:  62.50%\n\n", @cov.report
    end
    
    should "have a data hash" do
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
  
  end
end