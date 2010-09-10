# duvet

Install with
  
    (sudo) gem install duvet

Then add this to the __very__ top of your `test/helper.rb` (or similar)

    require 'duvet'
    Duvet.start

You can change the defaults by passing an options hash to Duvet.start, eg

    Duvet.start({:dir => 'coverage', :filter => 'app/lib'})

`:dir` is the directory to write the coverage to.
`:filter` allows you to display only coverage for files that include the string.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Joshua Hawxwell. See LICENSE for details.
