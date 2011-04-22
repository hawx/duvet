require_relative 'helper'

class TestPathname < MiniTest::Unit::TestCase

  def test_has_extension
    assert_equal 'txt', Pathname.new('folder/file.txt').extension
  end
  
  def test_has_file_name
    assert_equal 'file', Pathname.new('folder/file.txt').file_name
  end

end
