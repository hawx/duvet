require 'helper'

class TestDuvet < Test::Unit::TestCase

  should "have a version" do
    assert Duvet::VERSION
  end
  
  should "have defaults" do
    assert_equal({:dir => 'cov', :style => 'rcov'}, Duvet::DEFAULTS)
  end
  
  should "have a template path" do
    assert Duvet::TEMPLATE_PATH.include?('../templates')
  end


  context "something" do
    
    setup do
      # something
    end
    
    should "something" do
      assert_equal "your mum", "your face"
    end
    
  end

end
