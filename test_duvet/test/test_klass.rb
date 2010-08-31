$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'duvet'
Duvet.start({:dir => 'test_duvet/cov', :filter => 'test_duvet/'})


require 'rubygems'
require 'test/unit'
require 'shoulda'


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'klass'

class Test::Unit::TestCase
end


class TestKlass < Test::Unit::TestCase
  
  should "start out ok" do
    k = Klass.new
    assert_equal "EVERYTHING IS OK!", k.shout!
  end
  
  should "need help when alerted" do
    k = Klass.new
    k.alert!
    assert_equal true, k.help?
  end

  should "now shout for help" do
    k = Klass.new
    k.alert!
    assert_equal "I NEED HELP!", k.shout!
  end
    
end
