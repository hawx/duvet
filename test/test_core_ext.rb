require 'helper'

class TestString < Test::Unit::TestCase

  should "convert from String to Pathname" do
    assert_equal Pathname, "string".to_p.class
  end

end


class TestPathname < Test::Unit::TestCase

  should "have an extension" do
    assert_equal 'txt', Pathname.new('folder/file.txt').extension
  end
  
  should "have a file name" do
    assert_equal 'file', Pathname.new('folder/file.txt').file_name
  end

end