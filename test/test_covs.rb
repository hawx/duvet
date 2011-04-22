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

end