require_relative 'helper'

class TestDuvet < MiniTest::Unit::TestCase

  def test_has_version
    assert Duvet::VERSION
  end
  
  def test_has_defaults
    assert_equal({:dir => 'cov', :style => 'rcov'}, Duvet::DEFAULTS)
  end
  
  def test_has_template_path
    assert Duvet::TEMPLATE_PATH.to_s.include?('duvet/templates')
  end

end
