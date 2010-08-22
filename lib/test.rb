###
# This is MyClass.  There are many like it, but this one is mine.

class MyClass
  attr_accessor :coffee, :doughnuts

  def initialize
    @coffee    = 0
    @doughnuts = 0
  end

  def happy?
    @coffee > 2 && @doughnuts > 1
  end
end

instance = MyClass.new

5.times do
  instance.coffee += 1
end