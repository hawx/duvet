$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'duvet'
Duvet.start({:dir => 'cov', :filter => 'test_duvet/lib/'})


require 'rubygems'
require 'test/unit'
require 'shoulda'


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'klass'
require 'run'

class Test::Unit::TestCase
end

# This should run every line
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

# This one should not run every line
class TestRun < Test::Unit::TestCase

  # should "run it" do
  #   me = Run.new
  #   assert_equal "run it", me.run_it
  # end
  
  # should "run here" do
  #   me = Run.new
  #   assert_equal "run here", me.run_here
  # end
  
  should "run there" do
    me = Run.new
    assert_equal "run there", me.run_there
  end

end