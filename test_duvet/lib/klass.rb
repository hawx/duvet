class Klass

  attr_accessor :help
  
  def initialize
    @help = false
  end
  
  def alert!
    @help = true
  end
  
  def shout!
    if help?
      "I NEED HELP!"
    else
      "EVERYTHING IS OK!"
    end
  end

  def help?
    @help
  end

end